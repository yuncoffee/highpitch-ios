//
//  PracticeModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/22/24.
//

import Foundation


struct PracticeModel {
    var name: String
    var creatAt: Date
    var isRemarkable: Bool = false
    var isLocalStored: Bool = true
    var analysis: PracticeAnlysis
    var media: PracticeMedia
}

enum PracticeMediaType {
    case audio
    case video
}

struct PracticeMedia {
    var type: PracticeMediaType
    var path: String
}

struct PracticeAnlysis {
    
}
