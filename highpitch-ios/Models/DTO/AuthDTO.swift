//
//  AuthDTO.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/29/24.
//

import Foundation

struct SignUpRequest: Codable {
    let email: String
    let password: String
}

struct SignUpResponse: Codable {
    let success: Bool
    let message: String
}

struct SignInRequset: Codable {
    let email: String
    let password: String
}

struct SignInResponse: Codable {
    let success: Bool
    let token: String
}
