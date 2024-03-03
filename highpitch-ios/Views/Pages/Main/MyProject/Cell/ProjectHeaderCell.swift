//
//  ProjectHeaderCell.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/27/24.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout

class ProjectHeaderCell: UICollectionReusableView {
    static let identifier = "ProjectHeaderCell"
    
    fileprivate let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        label.text = "HELLO"
        backgroundColor = .green
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
