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
    private let navigationTitle = UILabel()
    let buttonTapsObservable = BehaviorSubject<(IndexPath, PracticeModel)?>(value: nil)
    let vm = ProjectDetailViewModel()
    var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfPracticeModel>?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    private func setup() {
        setupNavigationTitle()
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfPracticeModel>(
            configureCell: { _, collectionView, indexPath, practice in
                let cell: PracticeCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(with: practice)
                
                // MARK: 클릭한 아이템에 바인딩
                cell.remarkableButton.rx.tap
                    .map { _ in (indexPath, practice) }
                    .bind(to: self.buttonTapsObservable)
                    .disposed(by: cell.disposeBag)
                
                return cell
            }
        )
    }
    
    private func setupNavigationTitle() {
        navigationTitle.text = "Project"
        navigationTitle.font = .pretendard(.title3, weight: .semiBold)
        navigationItem.titleView = navigationTitle
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
        guard let dataSource = dataSource else { return }
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
        
        buttonTapsObservable
            .withUnretained(self)
            .subscribe { vc, result in
                guard let result = result else { return }
                let (indexPath, practice) = result
                vc.updateRemark(indexPath: indexPath, practice: practice)
            }
            .disposed(by: disposeBag)
    }
    
    override func loadView() {
        view = ProjectDetailView()
        mainView.layoutCell(selectedTab: vm.currentTabRelay.value)
    }
    
    func updateRemark(indexPath: IndexPath, practice: PracticeModel) {
        // MARK: 임시처리..
        var section = vm.sections.value
        section[indexPath.section].items[indexPath.row].isRemarkable.toggle()
        vm.sections.accept(section)
        print(practice.id)
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
        vm.sections.accept([SectionOfPracticeModel(model: "", items: project.practices)])
        mainView.configure(project)
        navigationTitle.text = project.name
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
