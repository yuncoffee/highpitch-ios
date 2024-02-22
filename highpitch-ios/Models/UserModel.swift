//
//  UserModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/22/24.
//

import Foundation
import UIKit

enum SignType {
    case custom
    case apple
    case google
}

struct UserModel {
    var signType: SignType
    var userName: String
    var profile: UIImage
    var epmRange: (min: Int, max: Int)
    var fillerWord: [String] = []
}
