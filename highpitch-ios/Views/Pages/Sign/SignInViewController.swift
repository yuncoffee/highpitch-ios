//
//  SignInViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

final class SignInViewController: UIViewController {
    
    // swiftlint: disable force_cast
    private var mainView: SignInView {
        view as! SignInView
    }
    // swiftlint: enable force_cast
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    override func loadView() {
        view = SignInView()
    }
    
    private func bind() {
        mainView.signInButton.rx.tap
            .withUnretained(self)
            .subscribe {vc, _ in
                vc.signIn()
            }
            .disposed(by: disposeBag)
    }
    
    private func setup() {
        view.backgroundColor = .white
    }
    
    // MARK: 로그인 기능 테스트용
    private func signIn() {
        guard let id = mainView.idTextField.text, !id.isEmpty,
              let password = mainView.passwordTextField.text, !password.isEmpty else {
                  print("둘 중 하나가 비워져 있음")
                  return
              }
        
        let mainVC =  UINavigationController(rootViewController: MainTabBarViewController())
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: false)
        mainView.idTextField.text = .none
        mainView.passwordTextField.text = .none
    }
    
    deinit {
        print("I'm Die")
    }
}

struct SignInViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            SignInViewController()
        }
    }
}
