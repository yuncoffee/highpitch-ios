//
//  Notification.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/3/24.
//

import Foundation
import UIKit

class NotificationViewController: UIViewController {
    private let label = LabelFactory.build(text: "NotificationView",
                                           font: .preferredFont(forTextStyle: .body),
                                           textAlignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    deinit {
        print("NotificationViewController Deinit")
    }
}
