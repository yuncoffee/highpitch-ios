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
import RxDataSources

protocol MyProjectViewDelegate: AnyObject {
    func pushNavigation(to link: Links, with project: ProjectModel?)
}

typealias SectionOfProjectModel = SectionModel<String, ProjectModel>

final class MyProjectViewController: UIViewController, MyProjectViewDelegate {
    // swiftlint: disable force_cast
    private var mainView: MyProjectView {
        return self.view as! MyProjectView
    }
    // swiftlint: enable force_cast
    
    private let vm = MyProjectViewModel()
    private let disposeBag = DisposeBag()
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfProjectModel>(
        configureCell: { _, collectionView, indexPath, project in
        let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: ProjectCell.identifier,
                                                      for: indexPath) as? ProjectCell
        cell?.configure(project: project)
        
        return cell ?? UICollectionViewCell()
        }, configureSupplementaryView: { dataSource, collectionview, title, indexPath in
            let header = collectionview
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: ProjectHeaderCell.identifier,
                                                  for: indexPath) as? ProjectHeaderCell
            let title = dataSource.sectionModels[indexPath.section].model
            
            header?.configure(title: title)

            return header ?? UICollectionReusableView()
        }
    
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    override func loadView() {
        view = MyProjectView()
    }
    
    override func viewWillTransition(to size: CGSize, 
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        mainView.viewOrientationDidChange()
    }
    
    private func setup() {
        mainView.delegate = self
        vm.sections.accept([
            SectionOfProjectModel(model: "내 프로젝트", items: MockModel.sampleProjects),
            SectionOfProjectModel(model: "너 프로젝트", items: MockModel.sampleProjects)
        ])
    }

    private func bind() {
        bindFABView()
        bindCollectionView()
        let input = MyProjectViewModel.Input(click: mainView.fabView.rx.tap)
        let output = vm.transform(input: input)
    }
    private func bindFABView() {
        mainView.fabView.rx.tap
            .subscribe { [weak self] _ in
            self?.pushNavigation(to: .recording, with: nil)
        }
        .disposed(by: disposeBag)
    }
    
    private func bindCollectionView() {
        vm.sections
            .bind(to: mainView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.itemSelected
            .subscribe { [weak self] indexPath in
                guard let self = self, let indexPath = indexPath.element else { return }
                self.pushNavigation(to: .projectDetail, 
                                    with:  vm.sections.value[indexPath.section].items[indexPath.row])
            }
            .disposed(by: disposeBag)
    }
    
    func pushNavigation(to link: Links, with project: ProjectModel?) {
        var vc: UIViewController?
        switch link {
        case .recording:
            vc = RecordingViewController()
        case .projectDetail:
            vc = ProjectDetailViewController()
            if let vc = vc as? ProjectDetailViewController, let project = project {
                vc.configure(with: project)
            }
        default:
            print("Invalid Link")
        }
        if let vc = vc {
            navigationController?.pushViewController(vc, animated: true)
        }
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
