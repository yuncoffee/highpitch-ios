//
//  RecordingAlertView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/8/24.
//

import Foundation
import UIKit
import SwiftUI
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa
import RxDataSources

extension RecordingViewController {
    final class SheetViewController: UIViewController, UICollectionViewDelegateFlowLayout {
        var dismissAction: ((Int) -> Void)?
        let saveButton = UIButton()
        private let cellTemplate = SelectProjectSheetCell()
        private let flowLayout = UICollectionViewFlowLayout()
        private var collectionView: UICollectionView?
        
        private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfProjectModel>?
        private var vm: RecordingViewModel?
        
        private let disposeBag = DisposeBag()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setup()
            bind()
        }
     
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            let height = view.frame.height - 56 - 16 - view.pin.safeArea.top - view.pin.safeArea.bottom
            collectionView?.pin.top(view.pin.safeArea).horizontally()
                .width(100%).height(height)
            saveButton.pin.below(of: collectionView!).hCenter()
                .width(view.frame.width - 32).height(56)
                .marginTop(16)
        }

        private func setup() {
            view.backgroundColor = .white
            setupCollectionView()
            setupNavigation()
        }
        
        private func setupCollectionView() {
            dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfProjectModel>(
                configureCell: { _, collectionView, indexPath, project in
                    let cell: SelectProjectSheetCell = collectionView.dequeueReusableCell(for: indexPath)
                    cell.configure(name: project.name)
                    
                    if indexPath == self.vm?.selectedIndexPath.value {
                        cell.updateLayout(true)
                    } else {
                        cell.updateLayout(false)
                    }
                    
                    return cell
                }
            )
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionHeadersPinToVisibleBounds  = true
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            
            guard let collectionView = collectionView else { return }
            
            collectionView.register(cellType: SelectProjectSheetCell.self)
            view.addSubview(collectionView)
        }
        
        private func setupNavigation() {
            let saveAction = UIAction { [weak self] _ in
                guard let self = self else { return }
                guard let indexPath = vm?.selectedIndexPath.value else { return }
                // MARK: 프로젝트를 선택할 수 있게 하기
                let selectedProject = vm?.sections.value[indexPath.section].items[indexPath.row].name ?? "선택X"
                vm?.projectName.accept(selectedProject)
                dismissAction?(1)
            }
            let titleLabel = UILabel()
            titleLabel.text = "내 프로젝트"
            titleLabel.font = .pretendard(.title2, weight: .semiBold)
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                                target: self,
                                                                action: #selector(close))
            
            saveButton.setTitle("저장하기", for: .normal)
            saveButton.addAction(saveAction, for: .touchUpInside)
            saveButton.flex.backgroundColor(UIColor.GrayScale.black).cornerRadius(8)
            view.addSubview(saveButton)
        }
        
        private func bind() {
            guard let collectionView = collectionView else { return }
            guard let dataSource = dataSource else { return }
            
            collectionView.rx.setDelegate(self).disposed(by: disposeBag)
            
            collectionView.rx.itemSelected
                .withUnretained(self)
                .subscribe { vc, indexPath in
                    vc.vm?.selectedIndexPath.accept(indexPath)
                    vc.collectionView?.reloadData()
                }
                .disposed(by: disposeBag)
            
            vm?.sections
                .bind(to: collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        }
        
        @objc func close() {
            dismiss(animated: true)
            dismissAction?(0)
        }
        
        // MARK: - 데이터 가져오기
        func configure(viewModel: RecordingViewModel) {
            vm = viewModel
//            vm?.sections.accept([SectionOfProjectModel(model: "projects", items: MockModel.sampleProjects)])
        }
                
        // swiftlint: disable line_length
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
            let height: CGFloat = 48
            
            return CGSize(width: width, height: height)
        }
        // swiftlint: enable line_length
        
        deinit {
            print("RecordingViewController Deinit")
        }
    }
}

struct SheetViewController_Previews: PreviewProvider {
    final class PresentVC: UIViewController {
        let vc = UINavigationController(rootViewController: RecordingViewController.SheetViewController())
        let vm = RecordingViewModel()
        let disposeBag = DisposeBag()
        private var button = UIButton()
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .gray
            button.setTitle("Open", for: .normal)
            button.addAction(UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                vc.modalPresentationStyle = .pageSheet
                if let sheet = vc.sheetPresentationController {
                    sheet.prefersGrabberVisible = true
                    sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                    sheet.detents = [.medium(), .large()]
                }
                present(vc, animated: true)
            }), for: .touchUpInside)
            view.addSubview(button)
            let sheetVC = vc.viewControllers.first! as? RecordingViewController.SheetViewController
            sheetVC?.configure(viewModel: vm)
            sheetVC?.saveButton.rx.tap.subscribe { _ in
                let sections = [SectionOfProjectModel(model: "projects", items: MockModel.sampleProjects)]
                self.vm.sections.accept(sections)
            }
            .disposed(by: disposeBag)
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            button.pin.all()
        }
    }
    
    static var previews: some View {
        ViewControllerPreview {
            PresentVC()
        }
    }
}
