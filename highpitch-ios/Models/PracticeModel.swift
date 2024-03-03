//
//  PracticeModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/22/24.
//

import Foundation

struct PracticeModel {
    let id = UUID().uuidString
    var name: String
    var creatAt: Date
    var isRemarkable: Bool = false
    var isLocalStored: Bool = true
    var analysis: PracticeAnalysis
    var media: PracticeMedia
}

enum PracticeMediaType {
    case audio
    case video
}

struct PracticeMedia {
    var type: PracticeMediaType
    var url: URL?
}

struct PracticeAnalysis {
    
}
