//
//  SettingsViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import PinLayout

class MyPageViewController: UIViewController {

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
