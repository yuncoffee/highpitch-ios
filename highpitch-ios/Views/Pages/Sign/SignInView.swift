//
//  SignInView.swift
//  highpitch-ios
//
//  Created by yuncoffee on 4/13/24.
//

import Foundation
import UIKit
import SwiftUI
import PinLayout
import FlexLayout

class SignInView: UIView {
    private let rootView = UIView()

    let signInButton = UIButton()
    
    let toFindIdButton = UIButton()
    let toFindPasswordButton = UIButton()
    let toSignUpButton = UIButton()
    
    let idTextField = UITextField()
    let passwordTextField = UITextField()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        signInButton.backgroundColor = .red
        signInButton.setTitle("로그인", for: .normal)
        signInButton.setTitleColor(.black, for: .normal)
        
        toSignUpButton.setTitle("회원가입", for: .normal)
        toSignUpButton.setTitleColor(.black, for: .normal)

        idTextField.placeholder = "사용자 ID 입력"
        idTextField.autocorrectionType = .no
        idTextField.spellCheckingType = .no
        idTextField.autocapitalizationType = .none
        idTextField.clearButtonMode = .always
        idTextField.clearsOnBeginEditing = false
        idTextField.leftView = .init(frame: .init(x: 0, y: 0, width: 16, height: self.frame.height))
        idTextField.leftViewMode = .always
        idTextField.font = .pretendard(.headline, weight: .medium)

        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "비밀번호 입력"
        passwordTextField.leftView = .init(frame: .init(x: 0, y: 0, width: 16, height: self.frame.height))
        passwordTextField.leftViewMode = .always
        
        rootView.flex.gap(16).define { flex in
            flex.addItem().define { flex in
                flex.addItem(idTextField)
                    .height(48)
                flex.addItem().height(1).backgroundColor(.gray)
                flex.addItem(passwordTextField)
                    .height(48)
            }
            .border(1, .gray).cornerRadius(6)
            
            flex.addItem(signInButton)
                .backgroundColor(.green)
            flex.addItem(toSignUpButton)
        }
        .padding(24)
        .border(2, .red)
        addSubview(rootView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all(pin.safeArea)
        rootView.flex.layout()
    }
}

struct SignInView_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            SignInView()
        }
    }
}
