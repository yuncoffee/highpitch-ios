//
//  MyPageInfoHeaderCell.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/15/24.
//

import UIKit
import SwiftUI
import PinLayout
import FlexLayout
import Reusable

final class MyPageInfoHeaderCell: UICollectionViewCell, Reusable {
    static let identifier = "MyPageInfoHeaderCell"
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel.text = "HEADER"
        titleLabel.textColor = .text
        
        contentView.flex.define { flex in
            flex.addItem(titleLabel)
                .margin(25, 24, 2)
        }
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

extension MyPageInfoHeaderCell {
    func configure(title: String) {
        titleLabel.text = title
        titleLabel.flex.markDirty()
        
        setNeedsLayout()
    }
}
 
#if DEBUG
struct MyPageInfoHeaderCell_Preview: PreviewProvider {
    static var previews: some View {
        let cell = MyPageInfoHeaderCell()
        let headerTitle = "내 정보"
        ViewPreview {
            cell.configure(title: headerTitle)
            
            return cell
        }
    }
}
#endif
