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
        self.view as! MyProjectView
    }
    // swiftlint: enable force_cast
    
    private let vm = MyProjectViewModel()
    private let disposeBag = DisposeBag()
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfProjectModel>?
    
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
    
    func setup() {
        mainView.delegate = self
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfProjectModel>(
            configureCell: { _, collectionView, indexPath, project in
            let cell: ProjectCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(project: project)
            
            return cell
            }, configureSupplementaryView: { dataSource, collectionview, title, indexPath in
                // swiftlint: disable line_length
                let header: ProjectHeaderCell = collectionview.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
                // swiftlint: enable line_length
                let title = dataSource.sectionModels[indexPath.section].model
                header.configure(title: title)

                return header
            }
        
        )
        #if DEBUG
        vm.sections.accept([
            SectionOfProjectModel(model: "내 프로젝트", items: MockModel.sampleProjects),
            SectionOfProjectModel(model: "너 프로젝트", items: MockModel.sampleProjects)
        ])
        #endif
    }

    private func bind() {
        bindFABView()
        bindCollectionView()
    }
    private func bindFABView() {
        mainView.fabView.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.pushNavigation(to: .recording, with: nil)
        }
        .disposed(by: disposeBag)
    }
    
    private func bindCollectionView() {
        guard let dataSource = dataSource else { return }
        
        vm.sections
            .bind(to: mainView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe { vc, indexPath in
                vc.pushNavigation(to: .projectDetail, 
                                  with: vc.vm.sections.value[indexPath.section].items[indexPath.row])
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
