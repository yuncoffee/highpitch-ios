//
//  ProjectsView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/22/24.
//

import Foundation
import FlexLayout
import PinLayout
import UIKit
import SwiftUI

class ProjectsView: UIView {
    fileprivate let rootView = UIView()
    fileprivate let myView = UIView()
    fileprivate let myView2 = UIView()
    
    init() {
        super.init(frame: .zero)
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        
        let segmentedControl = UISegmentedControl(items: ["Intro", "FlexLayout", "PinLayout"])
        segmentedControl.selectedSegmentIndex = 0
        
        let label = UILabel()
        label.text = "Flexbox layouting is simple, powerfull and fast.\n\nFlexLayout syntax is concise and chainable."
        label.numberOfLines = 0
        
        let bottomLabel = UILabel()
        bottomLabel.text = "FlexLayout/yoga is incredibly fast, its even faster than manual layout."
        bottomLabel.numberOfLines = 0
        
        // set Column
        rootView.flex.backgroundColor(.blue).border(2, .red).cornerRadius(24)
        
        rootView.flex.direction(.column).padding(12).define { flex in
            flex.addItem().direction(.row).define { flex in
                flex.addItem(imageView).width(100).aspectRatio(of: imageView).alignSelf(.center)
                
                flex.addItem().direction(.column).paddingLeft(12).grow(1).shrink(1).define { (flex) in
                    flex.addItem(segmentedControl).marginBottom(12).grow(1)
                    flex.addItem(label)
                }
            }
            flex.addItem().height(1).marginTop(12).backgroundColor(.lightGray)
            flex.addItem(bottomLabel).marginTop(12)
        }
        myView.backgroundColor = .red
        myView2.backgroundColor = .yellow
        
        addSubview(rootView)
        addSubview(myView)
        addSubview(myView2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.top(pin.safeArea.top).horizontally()
        rootView.flex.layout(mode: .adjustHeight)
        myView.pin.below(of: rootView).marginTop(24).height(300).width(of: rootView)
        myView2.pin.below(of: myView).bottom(pin.safeArea.bottom).marginTop(24).width(200)
        //        myView2.pin.after(of: myView, aligned: .top).bottomRight().marginLeft(10)
    }
}

struct ProjectsView_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            ProjectsView()
        }
    }
}
