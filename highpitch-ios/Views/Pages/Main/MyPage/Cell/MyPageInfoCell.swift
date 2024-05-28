//
//  MyPageInfoCell.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/15/24.
//

import UIKit
import SwiftUI
import PinLayout
import FlexLayout
import Reusable

final class MyPageInfoCell: UICollectionViewCell, Reusable {
    static let identifier = "MyPageInfoCell"
    
    private let titleLabel = UILabel()
    private let iconView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel.text = "LINK"
        iconView.image = UIImage(systemName: "chevron.right")?
            .withTintColor(.gray, renderingMode: .alwaysOriginal)
        iconView.contentMode = .scaleAspectFit
        
        contentView.flex.direction(.row).justifyContent(.spaceBetween).define { flex in
            flex.addItem(titleLabel)
            flex.addItem(iconView)
                .width(24).height(24)
        }
        .padding(12, 24)
        .minHeight(48)
    }
    
    private func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        
        return contentView.frame.size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

extension MyPageInfoCell {
    func configure(title: String) {
        titleLabel.text = title
        titleLabel.flex.markDirty()
        
        setNeedsLayout()
    }
}

struct MyPageInfoCell_Preview: PreviewProvider {
    static var previews: some View {
        let cell = MyPageInfoCell()
        let title = "프로필 정보"
        ViewPreview {
            cell.configure(title: title)
            
            return cell
        }
    }
}
