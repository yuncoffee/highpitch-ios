//
//  SettingsViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import PinLayout

class MyPageViewController: UIViewController {
    // swiftlint: disable force_cast
    private var mainView: MyPageView {
        self.view as! MyPageView
    }
    // swiftlint: enable force_cast

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        let button = UIButton()
        button.setTitle("Sign-Out", for: .normal)
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        
        view.addSubview(button)
        button.pin.all()
        // Do any additional setup after loading the view.
    }
    
    @objc func signOut() {
        dismiss(animated: true)
    }
    
    private func setup() {
        
    }
    
    private func bind() {
        
    }
}
