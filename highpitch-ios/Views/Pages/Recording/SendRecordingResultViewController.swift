//
//  SendPracticeResultViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/8/24.
//

import Foundation
import UIKit
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa

final class SendRecordingResultViewController: UIViewController {
    private let rootView = UIView()
    let titleLabel = UILabel()
    let button = UIButton()
    var vm: RecordingViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "로딩 중 화면"
        button.setTitle("버튼", for: .normal)
        button.addAction(UIAction(handler: {[weak self] _ in
            print(self?.vm?.projectName.value)
        }), for: .touchUpInside)
        
        rootView.flex.define { flex in
            flex.addItem(titleLabel)
            flex.addItem(button).width(200).backgroundColor(.blue)
        }
        .backgroundColor(.white)
        
        vm?.projectName
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
    }

    func updateLayout() {
        titleLabel.flex.markDirty()
        rootView.flex.layout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootView.pin.all()
        rootView.flex.layout()
    }
    
    override func loadView() {
        view = rootView
    }
    
    func configure(viewModel: RecordingViewModel) {
        vm = viewModel
    }
}
