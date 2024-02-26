//
//  ProjectModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/22/24.
//

import Foundation

struct ProjectModel {
    var name: String
    var creatAt: Date
    var editAt: Date
    var practices: [PracticeModel] = []
}
