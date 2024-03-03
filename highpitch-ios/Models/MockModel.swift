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
            PracticeModel(name: "Practice 1", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 2", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 3", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 4", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 5", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 6", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 7", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 8", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 9", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 10", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 11", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 12", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 13", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 14", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 15", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio))
        ]),
        ProjectModel(name: "Sample 2", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 3", creatAt: Date(), editAt: Date(), practices: [
            PracticeModel(name: "Practice 1", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 2", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio)),
            PracticeModel(name: "Practice 3", creatAt: Date(), analysis: PracticeAnalysis(), media: PracticeMedia(type: .audio))
        ]),
        ProjectModel(name: "Sample 4", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 5", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 6", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 7", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 8", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 9", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 10", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 11", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 12", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 13", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 14", creatAt: Date(), editAt: Date()),
        ProjectModel(name: "Sample 15", creatAt: Date(), editAt: Date())
    ]
    
}
// swiftlint: enable line_length
