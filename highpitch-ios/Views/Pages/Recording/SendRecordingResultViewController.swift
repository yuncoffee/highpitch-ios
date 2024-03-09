//
//  SendPracticeResultViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/8/24.
//

import Foundation
import UIKit
import PinLayout
import FlexLayout

final class SendRecordingResultViewController: UIViewController {
    private let rootView = UIView()
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "로딩 중 화면"
        
        rootView.flex.define { flex in
            flex.addItem(titleLabel)
        }
        .backgroundColor(.white)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootView.pin.all()
        rootView.flex.layout()
    }
    
    override func loadView() {
        view = rootView
    }
}
