//
//  RecordingViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit

class RecordingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        view.backgroundColor = .yellow
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let button = makeButton(withText: "Navigation!")
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        button.addTarget(self, action: #selector(dismissMain), for: .touchUpInside)
    }
    
    private func makeButton(withText text: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        
        return button
    }

    @objc func dismissMain() {
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
