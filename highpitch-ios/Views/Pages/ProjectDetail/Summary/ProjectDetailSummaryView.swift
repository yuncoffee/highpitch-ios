//
//  ProjectDetailSummaryView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/6/24.
//

import Foundation
import UIKit
import SwiftUI
import FlexLayout

final class ProjectDetailSummaryView: UIView {
    let scrollView = UIScrollView()
    private let contentView = UIView()
    
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .orange
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.contentInsetAdjustmentBehavior = .never
        contentView.flex.define { flex in
            flex.addItem().height(200).backgroundColor(.yellow)
            flex.addItem().height(400).backgroundColor(.blue)
            flex.addItem().height(300).backgroundColor(.purple)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.pin.all()
        scrollView.flex.layout()
        scrollView.contentSize = contentView.frame.size
    }
}

extension ProjectDetailViewModel {
    func configure(_ project: ProjectModel) {
        
    }
}

struct ProjectDetailSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            ProjectDetailSummaryView()
        }
    }
}
