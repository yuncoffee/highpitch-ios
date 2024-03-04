//
//  UIColor+Extension.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/27/24.
//

import Foundation
import UIKit

extension UIColor {
    static let primary = UIColor(hex: "#000000")
    static let text = UIColor(hex: "#000000")
    static let point = UIColor(hex: "#3A3241")
    static let recordDot = UIColor(hex: "#FF0000")
    static let stroke = UIColor(hex: "#000000", alpha: 0.08)
    
    struct PrimaryScale {
        static let primary = PrimaryScale.primary500
        
        static let primary100 = UIColor(hex: "#F1EDFF")
        static let primary200 = UIColor(hex: "#E3DEFE")
        static let primary300 = UIColor(hex: "#D0C5FF")
        static let primary400 = UIColor(hex: "#AD99FF")
        static let primary500 = UIColor(hex: "#8B6DFF")
        static let primary600 = UIColor(hex: "#6A4AEC")
    }
    
    struct GrayScale {
        static let gray0 = UIColor(hex: "#FFFFFF")
        static let gray200 = UIColor(hex: "#F2F3F5")
        static let gray400 = UIColor(hex: "#BFBFBF")
        static let gray600 = UIColor(hex: "#A6A6A6")
        static let gray800 = UIColor(hex: "#808080")
        static let gray1000 = UIColor(hex: "#000000")
        static let white = UIColor(hex: "#FFFFFF")
        static let black = UIColor(hex: "#000000")
    }
    
    struct TextScale {
        static let text900 = UIColor(hex: "#000000", alpha: 0.85)
        static let text800 = UIColor(hex: "#000000", alpha: 0.65)
        static let text700 = UIColor(hex: "#000000", alpha: 0.50)
        static let text500 = UIColor(hex: "#000000", alpha: 0.35)
        static let text300 = UIColor(hex: "#000000", alpha: 0.15)
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        // swiftlint: disable line_length
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        // swiftlint: enable line_length
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
