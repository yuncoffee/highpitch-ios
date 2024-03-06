//
//  HPSegmentedControl.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/6/24.
//

import Foundation
import UIKit
import SwiftUI
import PinLayout
import FlexLayout

class HPSegmentedControl: UIView {
    var items: [String]
    var segmentedControl: UISegmentedControl?
    
    private let rootView = UIView()
    private let underLineView = UIView()
    private let gapSize = 20.0
    private let marginSize = 20.0
    
    init(items: [String]) {
        self.items = items
        self.segmentedControl = SegmentedControlFactory.build(segments: items)
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(rootView)
        
        guard let segmentedControl = segmentedControl else { return }
        let segmentIndex = CGFloat(segmentedControl.numberOfSegments)
        let width = (UIScreen.main.bounds.width - marginSize * 2) / segmentIndex
        
        rootView.flex.define {
            $0.addItem(segmentedControl).height(40).marginHorizontal(20)
            $0.addItem(underLineView).position(.absolute).backgroundColor(UIColor.GrayScale.black)
                .width(width).height(3).top(37).left(marginSize)
        }
        segmentedControl.addAction(UIAction { [weak self] _ in
            self?.changeUnderLinePosition()
        }, for: .valueChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all()
        rootView.flex.layout(mode: .adjustHeight)
    }
    
    func addAction(_ completion: @escaping (_ selectedIndex: Int) -> Void) {
        guard let segmentedControl = segmentedControl else { return }
        
        segmentedControl.addAction(UIAction { _ in
            completion(segmentedControl.selectedSegmentIndex)
        }, for: .valueChanged)
    }
    
    private func changeUnderLinePosition() {
        guard let segmentedControl = segmentedControl else { return }
        let segmentIndex = CGFloat(segmentedControl.numberOfSegments)
        let width = (UIScreen.main.bounds.width - marginSize * 2) / segmentIndex
        
        let selectedIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let leadingDistance = width * selectedIndex + marginSize
        underLineView.flex.markDirty()
        setNeedsLayout()
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.underLineView.flex.left(leadingDistance)
            self.layoutIfNeeded()
        })
    }
}

struct HPSegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        let view = HPSegmentedControl(items: ["프로젝트 개요", "연습 리스트"])
        ViewPreview {
            view.addAction {selectedIndex in 
                print("selectedIndex: \(selectedIndex)")
            }
            return view
        }
    }
}
