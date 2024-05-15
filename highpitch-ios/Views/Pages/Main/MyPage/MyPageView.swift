//
//  MyPageView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/15/24.
//

import Foundation
import UIKit
import SwiftUI
import PinLayout
import FlexLayout

final class MyPageView: UIView, UICollectionViewDelegate {
    private let rootContainer = UIView()
    private let scrollView = UIScrollView()
    
    /// User Info ContainerView
    private let userInfoContainerView = UIView()
    private let userNameLabel = UILabel()
    private let userEmailLabel = UILabel()
    private let userProfileImageView = UIImageView()
    
    /// Link CollectionView
    let collectionView: UICollectionView
    private let flowLayout = UICollectionViewFlowLayout()
    private let cellTemplate = MyPageInfoCell()
    private let headerCellTemplate = MyPageInfoHeaderCell()
    
    /// Delegate
    weak var delegate: MyPageViewDelegate?
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        super.init(frame: .zero)
        
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.pin.all()
        rootContainer.pin.all()
        rootContainer.flex.layout(mode: .fitContainer)
        
        let collectionViewSize = collectionView.frame.size
        let userInfoContainerViewSize = userInfoContainerView.frame.size
        
        scrollView.contentSize = .init(width: collectionViewSize.width - userInfoContainerViewSize.width,
                                       height: collectionViewSize.height - userInfoContainerViewSize.height)
    }

    private func layout() {
        setupCollectionView()
        
        userNameLabel.text = "사용자 이름"
        userEmailLabel.text = "mail_address@gmail.com"
        userProfileImageView.backgroundColor = .gray
        
        rootContainer.flex.define { flex in
            // MARK: - UserInfoContainer
            flex.addItem(userInfoContainerView).direction(.row).gap(16).define { flex in
                flex.addItem(userProfileImageView)
                    .width(48).height(48)
                    .cornerRadius(24)
                flex.addItem().define { flex in
                    flex.addItem(userNameLabel)
                    flex.addItem(userEmailLabel)
                }
            }
            .padding(12, 24)
            // MARK: UICollectionView
            flex.addItem(collectionView)
                .grow(1)
        }
        addSubview(scrollView)
        scrollView.addSubview(rootContainer)
        backgroundColor = .white
    }
    
    private func setupCollectionView() {
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionHeadersPinToVisibleBounds  = true
        
        collectionView.delegate = self
        collectionView.register(cellType: MyPageInfoCell.self)
        collectionView.register(supplementaryViewType: MyPageInfoHeaderCell.self,
                                ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// swiftlint: disable line_length
extension MyPageView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellTemplate.sizeThatFits(.init(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.bounds.width, height: headerCellTemplate.getHeight())
    }
}
// swiftlint: enable line_length

struct MyPageView_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            MyPageView()
        }
    }
}
