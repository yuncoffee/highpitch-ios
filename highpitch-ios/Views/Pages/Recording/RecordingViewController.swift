//
//  RecordingViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import SwiftUI
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa

class RecordingViewController: UIViewController {
    // swiftlint: disable force_cast
    private var mainView: RecordingView {
        return self.view as! RecordingView
    }
    private let alert = UIAlertController(title: "프로젝트 저장", message: "저장할 프로젝트 선택", preferredStyle: .alert)
    private var finishPracticeAction: UIAction?
    let projectListVC = UINavigationController(rootViewController: AlertCusttomViewController())
    // swiftlint: enable force_cast
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    let projectName = BehaviorRelay(value: Date().description)
    let disposeBag = DisposeBag()
    
    private func setup() {
        mainView.outputLabel.text = projectName.value
        projectListVC.modalPresentationStyle = .pageSheet
        projectName
            .asDriver()
            .drive { [weak self] value in
                self?.mainView.outputLabel.text = value
                self?.mainView.setNeedsLayout()
            }
            .disposed(by: disposeBag)
        
        alert.addTextField { textField in
            textField.placeholder = self.projectName.value
            textField.text = self.projectName.value
        }
        alert.textFields?.first?.rx.text.orEmpty.bind(to: projectName).disposed(by: disposeBag)
        
        alert.addAction(.init(title: "기존 프로젝트에 저장", style: .default, handler: { [weak self] alert in
            guard let self = self else { return }
            
            self.mainView.outputLabel.text = self.projectName.value
            self.mainView.flex.layout()
            if let sheet = self.projectListVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
            }
            self.present(self.projectListVC, animated: true)
        }))
        alert.addAction(.init(title: "저장", style: .default, handler: { [weak self] alert in
            guard let self = self else { return }
            self.mainView.outputLabel.text = self.projectName.value
            self.mainView.flex.layout()
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
    
        finishPracticeAction = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.present(self.alert, animated: true)
        }
        
        let vc = projectListVC.viewControllers.first as? AlertCusttomViewController
        vc?.dismissAction = { [weak self] in
            guard let self = self else {return}
            present(alert, animated: true)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "연습 끝내기",
                                                            image: nil,
                                                            primaryAction: finishPracticeAction)
        
    }

    override func loadView() {
        view = RecordingView()
    }
}

extension RecordingViewController {
    class AlertCusttomViewController: UIViewController {
        private let label = UILabel()
        private let button = UIButton()
        private let rootView = UIView()
        private let toggle = UISwitch()
        var dismissAction: (() -> Void)?
        override func viewDidLoad() {
            super.viewDidLoad()
            print("열렸따구?")
            label.text = "어이어이 잡혔다."

            rootView.flex.justifyContent(.center).alignItems(.center).define { flex in
                flex.addItem(toggle)
            }
            .backgroundColor(.yellow)
            
        }
        
        override func loadView() {
            view = rootView
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            rootView.pin.all()
            rootView.flex.layout()
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            if toggle.isOn {
                dismissAction?()
            }
        }
        
        deinit {
            print("나 주거따")
        }
    }
}

struct RecordingViewController_Previews: PreviewProvider {
    
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController: RecordingViewController())
        }
    }
}

final class RecordingView: UIView {
    private let rootView = UIView()
    let outputLabel = UILabel()
    private let playButton = UIButton()
    private let pauseButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        
        playButton.setTitle("플레이", for: .normal)
        pauseButton.setTitle("퍼즈", for: .normal)
        
        rootView.flex.alignItems(.center).define { flex in
            let titleLabel = UILabel()
            titleLabel.text = "새로운 연습"
            outputLabel.text = ""
            flex.addItem(titleLabel)
            flex.addItem(outputLabel)
            flex.addItem().direction(.row).define { flex in
                flex.addItem(pauseButton).width(80).height(80)
                flex.addItem(playButton).width(80).height(80)
            }
            .width(100%)
            .backgroundColor(.blue)
        }
        .border(1, .red)
        
        addSubview(rootView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all(pin.safeArea)
        rootView.flex.layout()
        outputLabel.flex.markDirty()
    }
}
