//
//  PracticeView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import Foundation
import UIKit
import SwiftUI
import PinLayout
import FlexLayout

final class PracticeDetailView: UIView {
    fileprivate let titleLabel = UILabel()
    
    var practice: PracticeModel
    
    init(practice: PracticeModel) {
        self.practice = practice
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        titleLabel.text = practice.name
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.pin.all()
    }
}

extension PracticeDetailView {
    func configure(with practice: PracticeModel) {
        self.practice = practice
    }
}
