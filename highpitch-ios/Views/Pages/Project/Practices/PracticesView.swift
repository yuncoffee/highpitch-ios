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

final class PracticesView: UIView, UIScrollViewDelegate {
    private let collectionView: UICollectionView
    private let flowLayout = UICollectionViewFlowLayout()
    private let cellTemplate = PracticeCell()
    private var dataSource = Observable.of([PracticeModel]())
    private let disposeBag = DisposeBag()
    
    weak var delegate: ProjectViewDelegate?
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        super.init(frame: .zero)
        
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView.delegate = self
        collectionView.register(PracticeCell.self, forCellWithReuseIdentifier: PracticeCell.identifier)
        
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

extension PracticesView {
    func configure(with practices: [PracticeModel]) {
        dataSource = Observable.of(practices)
        
        dataSource.bind(to: collectionView.rx.items(
                cellIdentifier: PracticeCell.identifier,
                cellType: PracticeCell.self)) { rowIndex, practice, cell in
                    print(rowIndex)
                    cell.configure(with: practice)
                }
                .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(PracticeModel.self)
            .subscribe { practice in
                self.delegate?.pushNavigation(with: practice)
            }
            .disposed(by: disposeBag)
    }
    
    func viewOrientationDidChange() {
        flowLayout.invalidateLayout()
    }
}

// swiftlint: disable line_length
extension PracticesView:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellTemplate.sizeThatFits(.init(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
}
// swiftlint: enable line_length

struct PracticesView_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            PracticesView()
        }
    }
}
