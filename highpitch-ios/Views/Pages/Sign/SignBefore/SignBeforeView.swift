//
//  SignBeforeView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/28/24.
//

import Foundation
import SwiftUI
import UIKit

import FlexLayout
import PinLayout

final class SignBeforeView: UIView {
    private let rootView = UIView()
    
    let linkToSignUpButton = {
        let button = UIButton()
        button.setTitle("하이피치 시작하기", for: .normal)
        button.configuration = .filled()
        
        return button
    }()
    
    let linkToSignInButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.configuration = .plain()
        
        return button
    }()
    
    private let splashImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .landing)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let captionLabel = {
        let label = UILabel()
        label.text = "계정이 있으신가요?"
        
        return label
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
        
        rootView.flex.define {
            // ImageContainer
            $0.addItem().define {
                $0.addItem(splashImageView)
                    .maxHeight(244)
                    .marginTop(186)
            }
            .grow(1)
            // ButtonGroupContainer
            $0.addItem().gap(20).define {
                $0.addItem(linkToSignUpButton)
                $0.addItem().direction(.row).justifyContent(.center).gap(12).define {
                    $0.addItem(captionLabel)
                    $0.addItem(linkToSignInButton)
                }
            }
            .paddingHorizontal(24).paddingBottom(24)
        }
        
        addSubview(rootView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all(pin.safeArea)
        rootView.flex.layout()
    }
}

struct SignBeforeView_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            SignBeforeView()
        }
    }
}
