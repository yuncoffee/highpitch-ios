//
//  SignInViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import SwiftUI

final class SignInViewController: UIViewController {
    
    // swiftlint: disable force_cast
    private var mainView: SignInView {
        view as! SignInView
    }
    // swiftlint: enable force_cast
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        let button = makeButton(withText: "Sign-In")
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    private func makeButton(withText text: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        
        return button
    }
    
    @objc func signIn() {
        let mainVC =  UINavigationController(rootViewController: MainTabBarViewController())
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: false)
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
