//
//  SignUPPWView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/29/24.
//

import Foundation
import SwiftUI
import UIKit

import FlexLayout
import PinLayout

final class SignUPPWView: UIView {
    private let rootView = UIView()
    
    private let titleLabel = {
       let label = UILabel()
        label.text = "비밀번호를 생성해주세요!"
        
        return label
    }()
    
    let pwTextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    let validDescriptionLabel = {
        let label = UILabel()
        label.text = "중복되는 비밀번호"
        
        return label
    }()

    let signUpButton = {
        let button = UIButton()
        button.setTitle("계정 생성하기", for: .normal)
        button.configuration = .filled()
        
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
        
        rootView.flex.define {
            $0.addItem(titleLabel)
                .padding(28, 0, 16)
            $0.addItem().gap(12).define {
                $0.addItem(pwTextField)
                $0.addItem(validDescriptionLabel)
            }
            .paddingTop(24)
            .grow(1)
            $0.addItem(signUpButton)
                .marginBottom(28)
        }
        .paddingHorizontal(24)
        
        addSubview(rootView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all(pin.safeArea)
        rootView.flex.layout()
    }
}

#if DEBUG
struct SignUPPWView_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            SignUPPWView()
        }
    }
}
#endif
