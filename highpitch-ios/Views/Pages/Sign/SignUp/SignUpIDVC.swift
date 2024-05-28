//
//  SignUpIDVC.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/29/24.
//

import Foundation
import SwiftUI
import UIKit

import RxSwift
import RxCocoa

final class SignUpIDVC: UIViewController {
    // swiftlint: disable force_cast
    private var mainView: SignUPIDView {
        view as! SignUPIDView
    }
    // swiftlint: enable force_cast
    
    private let vm: SignVM
    private let disposeBag = DisposeBag()
    
    init(_ vm: SignVM) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }

    override func loadView() {
        view = SignUPIDView()
    }
    
    private func setup() {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func bind() {
        mainView.nextButton.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.next()
            }
            .disposed(by: disposeBag)
    }
}

extension SignUpIDVC {
    private func next() {
        let vc = SignUpPWVC(vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
