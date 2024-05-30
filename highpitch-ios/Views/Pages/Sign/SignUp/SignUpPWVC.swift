//
//  SignUpPWVC.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/29/24.
//

import Foundation
import SwiftUI
import UIKit

import RxSwift
import RxCocoa

final class SignUpPWVC: UIViewController {
    // swiftlint: disable force_cast
    private var mainView: SignUPPWView {
        view as! SignUPPWView
    }
    // swiftlint: enable force_cast
    
    private let vm: SignVM
    private let disposeBag = DisposeBag()
    
    init(_ vm: SignVM) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }

    override func loadView() {
        view = SignUPPWView()
    }
    
    private func setup() {
        print("Showing")
    }
    
    private func bind() {
        let input = SignVM.Input(signInButtonTap: nil, signUpButtonTap: mainView.signUpButton.rx.tap)
        let _ = vm.transform(input: input)
    }
}
