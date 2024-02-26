//
//  PracticeViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import Foundation
import UIKit

class PracticeViewController: UIViewController {
    // swiftlint: disable force_cast
    fileprivate var mainView: PracticeView {
        return self.view as! PracticeView
    }
    // swiftlint: enable force_cast
    
    var practice: PracticeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        
    }
    
    override func loadView() {
        if let practice = practice {
            view = PracticeView(practice: practice)
        }
    }
}
