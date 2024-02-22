//
//  SignInViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func setup() {
        let button = makeButton(withText: "Navigation!")
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
        let mainVC = MainTabBarViewController()
        mainVC.modalPresentationStyle = .fullScreen
//
        present(mainVC, animated: false)
//        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    deinit {
        print("I'm Die")
    }
}
