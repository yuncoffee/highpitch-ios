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
    private let segmentedControl = HPSegmentedControl(items: ["프로젝트 개요", "연습 리스트"])
    let projectDetailSummaryView = ProjectDetailSummaryView()
    let practicesView = PracticesView()

    // MARK: RX Test를 위한 버튼
    let button = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("뷰 바꾸는 버튼", for: .normal)
        return button
    }()
    
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
        guard let index = self.segmentedControl.segmentedControl?.selectedSegmentIndex else {return}
        
        segmentedControl.addAction { [weak self] selectedIndex in
            self?.layoutCell(index: selectedIndex)
        }
        rootView.flex.define { flex in
            flex.addItem(segmentedControl).marginTop(28)
            flex.addItem(projectDetailSummaryView)
            flex.addItem(practicesView)
        }
        layoutCell(index: index)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.top(pin.safeArea.top).horizontally().bottom()
        rootView.flex.layout()
        projectDetailSummaryView.pin.below(of: segmentedControl).horizontally().bottom()
        practicesView.pin.below(of: segmentedControl).horizontally().bottom()
    }
    
    func layoutCell(index: Int) {
        switch index {
        case 0:
            practicesView.alpha = 0
        case 1:
            practicesView.alpha = 1
        default:
            print("error")
        }
        projectDetailSummaryView.flex.markDirty()
        practicesView.flex.markDirty()
        setNeedsLayout()
    }
}

extension ProjectDetailView {
    func configure(with project: ProjectModel) {
        practicesView.configure(with: project.practices)
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let view = ProjectDetailView()
        ViewPreview {
            view.configure(with: MockModel.sampleProjects.first!)
            return view
        }
    }
}
