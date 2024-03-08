//
//  RecordingView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/8/24.
//

import Foundation
import UIKit
import PinLayout
import FlexLayout

final class RecordingView: UIView {
    private let rootView = UIView()
    let outputLabel = UILabel()
    private let playButton = UIButton()
    private let pauseButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        playButton.setTitle("플레이", for: .normal)
        pauseButton.setTitle("퍼즈", for: .normal)
        
        rootView.flex.alignItems(.center).define { flex in
            let titleLabel = UILabel()
            titleLabel.text = "새로운 연습"
            outputLabel.text = ""
            flex.addItem(titleLabel)
            flex.addItem(outputLabel)
            flex.addItem().direction(.row).define { flex in
                flex.addItem(pauseButton).width(80).height(80)
                flex.addItem(playButton).width(80).height(80)
            }
            .width(100%)
            .backgroundColor(.blue)
        }
        .border(1, .red)
        
        addSubview(rootView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all(pin.safeArea)
        rootView.flex.layout()
        outputLabel.flex.markDirty()
    }
}
