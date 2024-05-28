//
//  SplashVC.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/28/24.
//

import Foundation
import UIKit

import FlexLayout
import PinLayout

final class SplashVC: UIViewController {
    // swiftlint: disable force_cast
    private var mainView: SplashView {
        view as! SplashView
    }
    // swiftlint: enable force_cast
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showScreen()
        }
    }
    
    override func loadView() {
        view = SplashView()
    }
}

extension SplashVC {
    private func showScreen() {
        var vc: UIViewController?
        // 필요한 뷰모델 체크
        vc = UINavigationController(rootViewController: SignBeforeVC(SignVM()))
        
        guard let vc = vc else { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

final class SplashView: UIView {
    private let rootView = UIView()
    private let splashImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(resource: .landing)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        
        rootView.flex.define {
            $0.addItem(splashImageView)
                .maxHeight(244)
                .marginTop(202)
                .grow(1)
        }
        
        addSubview(rootView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all(pin.safeArea)
        rootView.flex.layout()
    }
}
