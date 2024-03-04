//
//  ProjectHeaderCell.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/27/24.
//

import Foundation
import UIKit
import SwiftUI
import FlexLayout
import PinLayout

class ProjectHeaderCell: UICollectionReusableView {
    static let identifier = "ProjectHeaderCell"
    private let rootView = UIView()
    private let label = UILabel()
    private let blurView = UIVisualEffectView()
    private var height = 56.0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let blurEffect = UIBlurEffect(style: .light)
        let vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        
        blurView.effect = blurEffect
        
        label.text = "HELLO"
        
        label.font = .pretendard(.title2, weight: .semiBold)

        rootView.flex.padding(16, 24, 16).define { flex in
            flex.addItem(label)
        }
        
        addSubview(blurView)
        blurView.contentView.addSubview(vibrancyView)
        
        addSubview(rootView)
    }
    
    func configure(title: String) {
        label.text = title
        label.flex.markDirty()
        setNeedsLayout()
    }
    
    func getHeight() -> CGFloat {
        height
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurView.pin.all()
        rootView.pin.all()
        rootView.flex.layout(mode: .adjustHeight)
    }
}

struct ProjectHeaderCell_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            ProjectHeaderCell()
        }
    }
}
