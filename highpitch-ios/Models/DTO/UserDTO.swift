//
//  UserDTO.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/29/24.
//

import Foundation

struct UserResponse: Codable {
    let id: Int
    let name: String
    let img: String?
    let roleType: String
    let loginType: String
}

struct APIFailureResponse: Codable, Error {
    let timestamp: String
    let status: Int
    let error: String
    let path: String
}
