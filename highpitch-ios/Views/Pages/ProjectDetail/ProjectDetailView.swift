//
//  ProjectView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import Foundation
import UIKit
import SwiftUI
import PinLayout
import FlexLayout

final class ProjectDetailView: UIView {
    private let rootView = UIView()
    let segmentedControl = HPSegmentedControl(items: ["프로젝트 개요", "연습 리스트"])
    let projectDetailSummaryView = ProjectDetailSummaryView()
    let practiceListView = PracticeListView()

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        addSubview(rootView)

        rootView.flex.define { flex in
            flex.addItem(segmentedControl)
            flex.addItem(projectDetailSummaryView)
            flex.addItem(practiceListView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.top(pin.safeArea.top).horizontally().bottom()
        rootView.flex.layout()
        projectDetailSummaryView.pin.below(of: segmentedControl).horizontally().bottom()
        practiceListView.pin.below(of: segmentedControl).horizontally().bottom()
    }
}

extension ProjectDetailView {
    func layoutCell(selectedTab: ProjectDetailViewTabs) {
        switch selectedTab {
        case .summary:
            practiceListView.alpha = 0
        case.practices:
            practiceListView.alpha = 1
        }
        segmentedControl.setSelectedSegmentIndex(selectedTab.rawValue)
        projectDetailSummaryView.flex.markDirty()
        practiceListView.flex.markDirty()
        setNeedsLayout()
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let view = ProjectDetailView()
        ViewPreview {
            return view
        }
    }
}
