//
//  PracticeCell.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import UIKit
import SwiftUI
import PinLayout
import FlexLayout

final class PracticeCell: UICollectionViewCell {
    static let identifier = "PracticeCell"
    
    fileprivate let titleLabel = UILabel()
    fileprivate let descriptionLabel = UILabel()
    fileprivate let remarkableIconView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel.text = "Title"
        descriptionLabel.text = "Description"
        
        remarkableIconView.image = UIImage(systemName: "star.fill")
        remarkableIconView.contentMode = .scaleAspectFit
        
        contentView.flex.direction(.row).justifyContent(.spaceBetween).define { flex in
            // left
            flex.addItem().define { flex in
                flex.addItem(titleLabel)
                flex.addItem(descriptionLabel)
            }
            // right
            flex.addItem(remarkableIconView)
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

extension PracticeCell {
    func configure(with practice: PracticeModel) {
        titleLabel.text = practice.name

        setNeedsLayout()
    }
}

struct PracticeCell_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            PracticeCell()
        }
    }
}
