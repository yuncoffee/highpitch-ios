//
//  OnboardingViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import SwiftUI

class OnboardingViewController: UIViewController {
    private let myView = ViewFactory.makeView(bgColor: .red)
    private let myView2 = ViewFactory.makeView(bgColor: .blue)
    private let myLabel = ViewFactory.makeLabel(text: "Hello, AutoLayout",
                                                font: .preferredFont(forTextStyle: .title1))
    
    private func setupUI() {
        view.addSubview(myView)
        view.addSubview(myView2)
//        myView.addSubview(myView2)
        view.addSubview(myLabel)

        
        
        NSLayoutConstraint.activate([
            
            myView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8),
            myView.widthAnchor.constraint(equalToConstant: 200),
            myView.heightAnchor.constraint(equalToConstant: 200),
            myView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
            myView2.widthAnchor.constraint(equalToConstant: 100),
            myView2.heightAnchor.constraint(equalToConstant: 100),
//            myView2.topAnchor.constraint(equalTo: myLabel.bottomAnchor),
//            myView2.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: 50),
            
            myLabel.topAnchor.constraint(equalTo: myView.bottomAnchor, constant: 16.0),
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

struct ViewFactory {
    static func makeView(bgColor: UIColor = .red) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = bgColor

        return view
    }
    
    static func makeLabel(text:String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.text = text
        
        return label
    }
}

struct OnboardingViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            OnboardingViewController()
        }
    }
}
