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
import Reusable
import RxSwift
import RxCocoa
import RxDataSources


extension RecordingViewController {
    final class SheetViewController: UIViewController, UICollectionViewDelegateFlowLayout {
        private let saveButton = UIButton()
        private var collectionView: UICollectionView?
        private let flowLayout = UICollectionViewFlowLayout()
        private let rootView = UIView()
        private let toggle = UISwitch()
        private let cellTemplate = SelectProjectSheetCell()
        private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfProjectModel>?
        var dismissAction: ((Int) -> Void)?
        let sections = BehaviorRelay(value: [SectionOfProjectModel]())
        var selectedIndexPath = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0)) {
            didSet {
                print(selectedIndexPath)
            }
        }
        
        private let disposeBag = DisposeBag()
        override func viewDidLoad() {
            super.viewDidLoad()
            sections.accept([SectionOfProjectModel(model: "projects", items: MockModel.sampleProjects)])
            
            dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfProjectModel>(
                configureCell: { _, collectionView, indexPath, project in
                    let cell: SelectProjectSheetCell = collectionView.dequeueReusableCell(for: indexPath)
                    cell.configure(name: project.name)

                    if indexPath == self.selectedIndexPath.value {
                        cell.update(color: .red)
                    } else {
                        cell.update(color: .blue)
                    }
                    
                    return cell
                }
            )
            
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionHeadersPinToVisibleBounds  = true
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            guard let dataSource = dataSource else { return }
            guard let collectionView = collectionView else { return }
            
            collectionView.register(cellType: SelectProjectSheetCell.self)
            collectionView.rx.setDelegate(self).disposed(by: disposeBag)
            collectionView.backgroundColor = .green
            
            let saveAction = UIAction { [weak self] _ in
                guard let self = self else { return }
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
            
            saveButton.flex.backgroundColor(.point).cornerRadius(8)
            rootView.flex.backgroundColor(.white)
            
            view.addSubview(collectionView)
            view.addSubview(saveButton)
            
            sections
                .bind(to: collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
            
            collectionView.rx.itemSelected
                .withUnretained(self)
                .subscribe { vc, indexPath in
                    vc.selectedIndexPath.accept(indexPath)
                    vc.collectionView?.reloadData()
                }
                .disposed(by: disposeBag)
            
        }
        
        @objc func close() {
            dismiss(animated: true)
        }
        
        override func loadView() {
            view = rootView
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            rootView.flex.layout()
            let height = view.frame.height - 56 - 16 - view.pin.safeArea.top - view.pin.safeArea.bottom
            
            collectionView?.pin.top(view.pin.safeArea).horizontally()
                .width(100%).height(height)
            saveButton.pin.below(of: collectionView!).hCenter()
                .width(view.frame.width - 32).height(56)
                .marginTop(16)
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            if toggle.isOn {
                dismissAction?(0)
            }
        }
        
        deinit {
            print("RecordingViewController Deinit")
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
            let height: CGFloat = 48 // 셀의 고정된 높이
            
            return CGSize(width: width, height: height)
        }
    }
}

struct SheetViewController_Previews: PreviewProvider {
    final class PresentVC: UIViewController {
        let vc = UINavigationController(rootViewController: RecordingViewController.SheetViewController())
        private var button = UIButton()
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .red
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

final class SelectProjectSheetCell: UICollectionViewCell, Reusable {
    private let titleLabel: UILabel
    private let selectedImage: UIImageView
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        titleLabel.text = "2023.12.30 오후 8시 23분"
        selectedImage = UIImageView()
        selectedImage.image = UIImage(systemName: "checkmark")
        
        super.init(frame: frame)
        
        contentView.flex.direction(.row).alignItems(.center).justifyContent(.spaceBetween).define { flex in
            flex.addItem(titleLabel).marginLeft(24)
            flex.addItem().define { flex in
                flex.addItem(selectedImage)
            }
            .width(20).height(20).cornerRadius(10)
            .marginRight(24)
        }
        .height(48).backgroundColor(.brown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    func configure(name: String) {
        titleLabel.text = name
        titleLabel.flex.markDirty()
        setNeedsLayout()
    }
    
    func update(color: UIColor) {
        contentView.flex.backgroundColor(color)
        contentView.flex.markDirty()
        setNeedsLayout()
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
          // prepareForReuse 에서 명시적 구독 해제를 해야한다.
         disposeBag = DisposeBag()
     }
}

struct SelectProjectSheetCell_Preview: PreviewProvider {
    static var previews: some View {
        let cell = SelectProjectSheetCell()
        let projectModel = ProjectModel(name: "프로젝트 명", creatAt: Date(), editAt: Date())
        
        ViewPreview {
            cell.configure(name: projectModel.name)
            return cell
        }
    }
}
