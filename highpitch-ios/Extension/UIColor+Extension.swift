//
//  UIColor+Extension.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/27/24.
//

import Foundation
import UIKit

extension UIColor {
    static let point = UIColor(hex: "#3A3241")
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
