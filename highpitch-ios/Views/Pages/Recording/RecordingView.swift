//
//  RecordingView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/8/24.
//

import Foundation
import UIKit
import SwiftUI
import PinLayout
import FlexLayout

final class RecordingView: UIView {
    private let rootView = UIView()
    private let recordingIndicatorView = UIView()
    private let voiceIndicatorView = UIView()
    let durationLabel = UILabel()
    private let playButton = UIButton()
    let stopButton = UIButton()
    private let symbolConfig = UIImage.SymbolConfiguration(font: .pretendard(name: .medium, size: 26))
    private var isPlay = false
    private var recordingDotAnimation: UIViewPropertyAnimator?
    
    init() {
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        let stopIcon = UIImage(systemName: "stop.fill", withConfiguration: symbolConfig)?
            .withTintColor(.point, renderingMode: .alwaysOriginal)
        let pauseIcon = UIImage(systemName: "pause.fill", withConfiguration: symbolConfig)?
            .withTintColor(.point, renderingMode: .alwaysOriginal)
        stopButton.setImage(stopIcon, for: .normal)
        playButton.setImage(pauseIcon, for: .normal)
        playButton.addAction(UIAction {_ in self.playRecord() }, for: .touchUpInside)
        
        rootView.flex.alignItems(.center).justifyContent(.spaceBetween).define { flex in
            flex.addItem().gap(4).justifyContent(.center).alignItems(.center).define { flex in
                let titleLabel = UILabel()
                titleLabel.text = "새로운 연습"
                titleLabel.font = .pretendard(.title1, weight: .medium)
                titleLabel.textColor = UIColor.GrayScale.gray600
                durationLabel.text = "00:00:00"
                durationLabel.font = .pretendard(.title1, weight: .bold)
                durationLabel.textColor = UIColor.GrayScale.gray1000
                
                flex.addItem(titleLabel).marginTop(64)
                flex.addItem().direction(.row).alignItems(.center).gap(16).define { flex in
                    flex.addItem(recordingIndicatorView)
                        .width(16).height(16)
                        .backgroundColor(.recordDot)
                        .cornerRadius(8)
                    flex.addItem(durationLabel)
                }
                
            }
            flex.addItem().direction(.row).justifyContent(.spaceEvenly).define { flex in
                flex.addItem(stopButton).width(80).height(80)
                flex.addItem(playButton)
                    .backgroundColor(UIColor.GrayScale.gray200).cornerRadius(40)
                    .width(80).height(80)
                flex.addItem().width(80).height(80)
            }
            .width(100%)
            .marginBottom(24)
        }
        
        voiceIndicatorView.flex.justifyContent(.center).alignItems(.center).define { flex in
            flex.addItem().direction(.row).justifyContent(.center).alignItems(.center).gap(8).define { flex in
                for _ in 1...25 {
                    flex.addItem().width(4).height(50).backgroundColor(.point).cornerRadius(2)
                }
            }
            .width(100%).height(50)
        }
        
        addSubview(voiceIndicatorView)
        addSubview(rootView)
    }
    
    func updateLayout() {
        durationLabel.flex.markDirty()
        rootView.flex.layout()
    }
    
    func updateVoiceIndicatorView() {
        voiceIndicatorView.flex.markDirty()
        setNeedsLayout()
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            
            layoutIfNeeded()
        }
    }
    
    func startAnimation() {
        guard !isPlay else { return }
        isPlay = true
        UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.recordingIndicatorView.alpha = 0
        }, completion: nil)
    }
    
    func stopAnimation() {
        guard isPlay else { return }
        isPlay = false
        recordingIndicatorView.layer.removeAllAnimations()
        recordingIndicatorView.alpha = 1
    }
    
    func playRecord() {
        if isPlay {
            print("잠시 멈춰!")
            stopAnimation()
        } else {
            print("녹음 시작")
            startAnimation()
        }
    }
    
    func stopRecord() {
        print("멈춰!")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        voiceIndicatorView.pin.all(pin.safeArea)
        voiceIndicatorView.flex.layout()
        rootView.pin.all(pin.safeArea)
        rootView.flex.layout()
        durationLabel.flex.markDirty()
    }
}

struct RecordingView_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            RecordingView()
        }
    }
}
