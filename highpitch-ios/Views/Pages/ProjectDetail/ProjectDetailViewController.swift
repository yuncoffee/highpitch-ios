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
import RxDataSources

protocol ProjectViewDelegate: AnyObject {
    func pushNavigation(with: PracticeModel)
}

typealias SectionOfPracticeModel = SectionModel<String, PracticeModel>

class ProjectDetailViewController: UIViewController, ProjectViewDelegate {
    // swiftlint: disable force_cast
    private var mainView: ProjectDetailView {
        return self.view as! ProjectDetailView
    }
    // swiftlint: enable force_cast
    let vm = ProjectDetailViewModel()
    private let disposeBag = DisposeBag()
    private let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfPracticeModel>(
        configureCell: { _, collectionView, indexPath, practice in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PracticeCell.identifier,
                                                          for: indexPath) as? PracticeCell
            cell?.configure(with: practice)

            return cell ?? UICollectionViewCell()
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    private func setup() {
        setupNavigationTitle()
    }
    
    private func setupNavigationTitle() {
        let label = UILabel()
        label.text = "Project"
        label.font = .pretendard(.title3, weight: .semiBold)
        navigationItem.titleView = label
    }
    
    private func bind() {
        inOutBind()
        bindCollectionView()
    }

    private func inOutBind() {
        guard let segmentedControl = mainView.segmentedControl.segmentedControl else { return }
        
        let input = ProjectDetailViewModel.Input(
            segmentedControlTap: segmentedControl.rx.controlEvent(.valueChanged),
            selectedSegmentedControl: segmentedControl.rx.selectedSegmentIndex
        )
        let output = vm.transform(input: input)
        
        output.segmentedControlTap
            .withUnretained(self)
            .bind { vc, _ in
                vc.mainView.layoutCell(selectedTab: vc.vm.currentTabRelay.value)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindCollectionView() {
        let collectionView = mainView.practiceListView.collectionView
        vm.sections
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe { vc, indexPath in
                let practice = vc.vm.sections.value[indexPath.section].items[indexPath.row]
                vc.pushNavigation(with: practice)
            }
            .disposed(by: disposeBag)
    }
    
    override func loadView() {
        view = ProjectDetailView()
        mainView.practiceListView.delegate = self
        mainView.layoutCell(selectedTab: vm.currentTabRelay.value)
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
        vm.sections.accept([SectionOfPracticeModel(model: "", items: project.practices)])
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
