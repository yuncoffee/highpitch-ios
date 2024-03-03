//
//  ProjectsViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

protocol MyProjectViewDelegate: AnyObject {
    func pushNavigation(with: ProjectModel)
}

final class MyProjectViewController: UIViewController, MyProjectViewDelegate {
    
    // swiftlint: disable force_cast
    fileprivate var mainView: MyProjectView {
        return self.view as! MyProjectView
    }
    // swiftlint: enable force_cast
    
    private let vm = MyProjectViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    override func loadView() {
        view = MyProjectView()
        // view가 로드된 이후에 데이터를 바인딩한다.
        mainView.configure(with: MockModel.sampleProjects)
    }
    
    // swiftlint: disable line_length
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        mainView.viewOrientationDidChange()
    }
    // swiftlint: enable line_length
    
    private func setup() {
        mainView.delegate = self
    }
    
    func pushNavigation(with project: ProjectModel) {
        let projectVC = ProjectViewController()
        projectVC.configure(with: project)
        navigationController?.pushViewController(projectVC, animated: true)
    }
    
    func bind() {
        let input = MyProjectViewModel.Input(click: mainView.headerView.rx.tap)
        
        let output = vm.transform(input: input)
        
        output.text
            .drive(mainView.myLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("ProjectsVC Deinit")
    }
}

struct ProjectsViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            MyProjectViewController()
        }
    }
}
