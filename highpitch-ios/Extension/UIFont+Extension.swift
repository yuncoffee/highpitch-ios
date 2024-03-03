//
//  UIFont+Extension.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/3/24.
//

import Foundation
import UIKit

extension UIFont {
    static func pretendard(name: PretendardFont, size: CGFloat) -> UIFont {
        UIFont(name: name.rawValue, size: size) ?? .preferredFont(forTextStyle: .body)
    }

    struct Pretendard {
        static let body = UIFont(name: PretendardFont.bold.rawValue, size: 14)
        
        static func registerFonts() {
            PretendardFont.allCases.forEach { registerFont(bundle: .main, fontName: $0.rawValue, fontExtension: "otf") }
        }
    }
}

func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
    guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
          let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
          let font = CGFont(fontDataProvider) else {
        fatalError("Could't create font from filename: \(fontName) with extension \(fontExtension)")
    }
    var error: Unmanaged<CFError>?
    CTFontManagerRegisterGraphicsFont(font, &error)
}

enum PretendardFont: String, CaseIterable {
    case black = "Pretendard-Black"
    case regular = "Pretendard-Regular"
    case bold = "Pretendard-Bold"
    case medium = "Pretendard-Medium"
    case light = "Pretendard-Light"
    case semiBold = "Pretendard-SemiBold"
}
