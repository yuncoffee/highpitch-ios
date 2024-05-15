//
//  Actions.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/2/24.
//

import Foundation
import AVFoundation

enum Links {
    case recording
    case searchProject
    case notification
    case projectDetail
}

enum MyPageLinks: String {
    case profile = "프로필 정보"
    case account = "계정 정보"
    case myFillerWord = "내 습관어 변경"
    case mySpeakingSpeed = "내 말빠르기 기준 변경"
    case myTheme = "테마 변경"
    case myData = "데이터 저장 관리"
    case help = "1:1 문의하기"
    case terms = "이용 약관"
    case myOpinion = "의견 보내기"
    case appVersion = "앱 버전"
}

protocol ProjectUseCase {
    func fetchs() -> [ProjectModel]
    func update(_ item: ProjectModel) // ID로 변경하는게 좋을듯
    func delete(_ item: ProjectModel)
    func deleteAll()
    func add(_ item: ProjectModel)
    func search(name: String) -> [ProjectModel]
}

protocol PracticeUseCase {
    func fetchs() -> [PracticeModel]
    func update(_ item: PracticeModel)
    func delete(_ id: String)
    func deleteAll()
    func add(_ item: PracticeModel)
    func remark(_ id: String)
    func requestMedia(_ id: String, type: PracticeMedia)
    func requestAnalysis(_ id: String) -> PracticeAnalysis
}

protocol AnlaysisUseCase {
    func analysis(media: URL) -> PracticeAnalysis
}

protocol UserUseCase {
    func signIn(email: String, password: String)
    func signUp(email: String, password: String)
    func signOut()
    func leave()
    func updateBenchmark(_ userSpm: UserSpm)
    func updateProfile(image: URL)
    func updatePassword(password: String)
}
