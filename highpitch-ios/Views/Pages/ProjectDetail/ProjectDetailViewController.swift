//
//  ProjectViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import UIKit
import SwiftUI
import RxCocoa
import RxSwift

protocol ProjectViewDelegate: AnyObject {
    func pushNavigation(with: PracticeModel)
}

class ProjectDetailViewController: UIViewController, ProjectViewDelegate {
    // swiftlint: disable force_cast
    private var mainView: ProjectDetailView {
        return self.view as! ProjectDetailView
    }
    // swiftlint: enable force_cast
    let vm = ProjectDetailViewModel()
    
    let currentTabRelay = BehaviorRelay(value: ProjectDetailViewTabs.summary)
    let disposeBag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }

    private func setup() {
        let label = UILabel()
        label.text = "Project"
        label.font = .pretendard(.title3, weight: .semiBold)
        
        navigationItem.titleView = label
    }
    
    private func bind() {
        let input = ProjectDetailViewModel.Input(segmentedControlTap: mainView.button.rx.tap)
        let output = vm.transform(input: input)
        
        output.segmentedControlTap
                .withUnretained(self)
                .bind { vc, _ in
                    print(vc.vm.project?.creatAt)
                }
                .disposed(by: disposeBag)
    }

    override func loadView() {
        view = ProjectDetailView()
        mainView.practicesView.delegate = self
        
        if let project = vm.project {
            mainView.configure(with: project)
        }
    }
    
    func test() {
        print("HHH")
    }
    
    func pushNavigation(with practice: PracticeModel) {
        let practiceVC = PracticeDetailViewController()
        practiceVC.practice = practice
        navigationController?.pushViewController(practiceVC, animated: true)
    }

    deinit {
        print("ProjectVC Deinit")
    }
}

extension ProjectDetailViewController {
    func configure(with project: ProjectModel) {
        vm.project = project
    }
}

struct ProjectViewController_Previews: PreviewProvider {
    static var previews: some View {
        let vc = ProjectDetailViewController()

        ViewControllerPreview {
            vc.configure(with: MockModel.sampleProjects.first!)
            
            return UINavigationController(rootViewController: vc)
        }
    }
}
