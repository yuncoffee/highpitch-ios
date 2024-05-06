//
//  HPButton.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/6/24.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout

struct HPButtonFactory {
    static func buildButton(_ title: String, isActive: Bool = false) -> UIButton {
        let _button = UIButton()
        
        _button.setTitle(title, for: .normal)
        _button.setTitleColor(.white, for: .normal)
        
        if isActive {
            _button.backgroundColor = .red
            _button.setTitleColor(.white, for: .normal)
        } else {
            _button.backgroundColor = .blue
            _button.setTitleColor(.gray, for: .normal)
        }

        return _button
    }
}

#if DEBUG
import SwiftUI
import RxSwift
import RxCocoa

private final class PreviewUIView: UIView {
    let rootView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(rootView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all(pin.safeArea)
        rootView.flex.layout()
    }
}

struct HPButton_Preview: PreviewProvider {
    static var previews: some View {
        let button = HPButtonFactory.buildButton("Hello")
        let button2 = HPButtonFactory.buildButton("World",
                                                  isActive: true)
        let disposedBag = DisposeBag()
        let rootView = PreviewUIView()

        ViewPreview {
            button.rx.tap.subscribe { _ in
                print("HELLO")
                button2.backgroundColor = .darkGray
                button.backgroundColor = .blue
            }
            
            .disposed(by: disposedBag)
            
            button2.rx.tap.subscribe { _ in
                print("World")
                button2.backgroundColor = .red
                button.backgroundColor = .black
                
            }
            .disposed(by: disposedBag)
            
            rootView.rootView.flex.define {
                $0.addItem(button)
                    .width(100).height(60)
                    .alignSelf(.end)
                $0.addItem(button2)
                    .width(80).height(120)
                    .alignSelf(.center)
                    .border(2, .green)
            }
            .gap(24)
            .backgroundColor(.yellow)
            
            rootView.setNeedsLayout()
            
            
            return rootView
        }
        .border(.red)
    }
}
#endif
