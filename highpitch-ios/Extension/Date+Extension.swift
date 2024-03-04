//
//  Date+Extension.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/4/24.
//

import Foundation

extension Date {
    static func createAtToHMS(input: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        
        if let date = inputFormatter.date(from: input) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy.MM.dd · HH:mm"
            
            let dateString = outputFormatter.string(from: date)
            
            return dateString
        } else {
            return "Invalid Date"
        }
    }
}
