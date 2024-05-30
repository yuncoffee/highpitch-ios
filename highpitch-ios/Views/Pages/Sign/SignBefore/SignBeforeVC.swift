//
//  SignBeforeVC.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/28/24.
//

import Foundation
import SwiftUI
import UIKit

import RxSwift
import RxCocoa

final class SignBeforeVC: UIViewController {
    // swiftlint: disable force_cast
    private var mainView: SignBeforeView {
        view as! SignBeforeView
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
        view = SignBeforeView()
    }
    
    private func setup() {
        navigationController?.isNavigationBarHidden = true
        print("setup SignBeforeVC")
    }
    
    private func bind() {
        let input = SignVM.Input(
            signInButtonTap: mainView.linkToSignInButton.rx.tap,
            signUpButtonTap: nil
        )
        
        let output = vm.transform(input: input)
        
        mainView.linkToSignInButton.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.signIn()
            }
            .disposed(by: disposeBag)
        
        mainView.linkToSignUpButton.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.signUp()
            }
            .disposed(by: disposeBag)
    }
}

extension SignBeforeVC {
    private func signIn() {
        
    }
    
    private func signUp() {
        let vc = SignUpIDVC(vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}

#if DEBUG
struct SignBeforeVC_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController: SignBeforeVC(SignVM()))
        }
    }
}
#endif
