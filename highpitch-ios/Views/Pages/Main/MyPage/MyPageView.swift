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

final class MyPageView: UIView {
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
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        super.init(frame: .zero)
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootContainer.pin.all(pin.safeArea)
        rootContainer.flex.layout(mode: .fitContainer)
        scrollView.contentSize = rootContainer.frame.size
    }

    private func layout() {
        userNameLabel.text = "사용자 이름"
        userEmailLabel.text = "mail_address@gmail.com"
        userProfileImageView.backgroundColor = .gray
        
        rootContainer.flex.define { flex in
            flex.addItem(scrollView).define { flex in
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
            }
        }
        
        addSubview(rootContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct MyPageView_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            MyPageView()
        }
    }
}
