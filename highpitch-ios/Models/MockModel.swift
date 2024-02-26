//
//  MockModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/26/24.
//

import Foundation

// swiftlint: disable line_length
struct MockModel {
    static let sampleProjects: [ProjectModel] = [
        ProjectModel(name: "Sample 1", creatAt: Date(), editAt: Date(), practices: [
            PracticeModel(name: "Practice 1", creatAt: Date(), analysis: PracticeAnlysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 2", creatAt: Date(), analysis: PracticeAnlysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 3", creatAt: Date(), analysis: PracticeAnlysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 4", creatAt: Date(), analysis: PracticeAnlysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 5", creatAt: Date(), analysis: PracticeAnlysis(), media: PracticeMedia(type: .audio))
        ]),
        ProjectModel(name: "Sample 2", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 3", creatAt: Date(), editAt: Date(), practices: [
            PracticeModel(name: "Practice 1", creatAt: Date(), analysis: PracticeAnlysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 2", creatAt: Date(), analysis: PracticeAnlysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 3", creatAt: Date(), analysis: PracticeAnlysis(), media: PracticeMedia(type: .audio))
        ]),
        ProjectModel(name: "Sample 4", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 5", creatAt: Date(), editAt: Date())
    ]
    
}
// swiftlint: enable line_length
