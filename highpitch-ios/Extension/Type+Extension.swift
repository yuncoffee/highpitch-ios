//
//  Type+Extension.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/27/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
