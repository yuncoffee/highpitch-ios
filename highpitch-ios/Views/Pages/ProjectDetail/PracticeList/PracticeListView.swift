//
//  PracticesView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import Foundation
import UIKit
import SwiftUI
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa
import RxDataSources

final class PracticeListView: UIView, UIScrollViewDelegate {
    let collectionView: UICollectionView
    private let flowLayout = UICollectionViewFlowLayout()
    private let cellTemplate = PracticeCell()
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        super.init(frame: .zero)
        
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView.delegate = self
        collectionView.register(cellType: PracticeCell.self)
        
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.pin.all()
    }
}

extension PracticeListView {
    func viewOrientationDidChange() {
        flowLayout.invalidateLayout()
    }
}

// swiftlint: disable line_length
extension PracticeListView:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellTemplate.sizeThatFits(.init(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
}
// swiftlint: enable line_length

struct PracticesView_Preview: PreviewProvider {
    static var previews: some View {
        let view = PracticeListView()
        let disposeBag = DisposeBag()
        let vm = ProjectDetailViewModel()
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfPracticeModel>(
            configureCell: { _, collectionView, indexPath, practice in
                let cell: PracticeCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(with: practice)

                return cell
            }
        )
        let collectionView = view.collectionView
        
        ViewPreview {
            return view
        }
        .onAppear {
            let model = [SectionOfPracticeModel(model: "", items: MockModel.sampleProjects.first!.practices)]
            vm.sections.accept(model)
            vm.sections
                .bind(to: collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
            collectionView.rx.itemSelected.subscribe { indexPath in
                print(indexPath)
            }.disposed(by: disposeBag)
        }
    }
}
