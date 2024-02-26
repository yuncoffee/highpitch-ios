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

final class PracticesView: UIView {
    fileprivate let collectionView: UICollectionView
    fileprivate let flowLayout = UICollectionViewFlowLayout()
    fileprivate let cellTemplate = PracticeCell()
    
    fileprivate var practices: [PracticeModel] = []
    
    weak var delegate: ProjectViewDelegate?
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        super.init(frame: .zero)
        
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        collectionView.dataSource = self
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
        self.practices = practices
        collectionView.reloadData()
    }
    
    func viewOrientationDidChange() {
        flowLayout.invalidateLayout()
    }
}

// swiftlint: disable line_length
extension PracticesView:  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        practices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint: disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PracticeCell.identifier, for: indexPath) as! PracticeCell
        // swiftlint: enable force_cast
        cell.configure(with: practices[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellTemplate.sizeThatFits(.init(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushNavigation(with: practices[indexPath.row])
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
