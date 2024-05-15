//
//  MyPageViewModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/15/24.
//

import Foundation
import RxSwift
import RxCocoa

final class MyPageViewModel {
    let sections = BehaviorRelay(value: [SectionOfMyPageInfo]())
    let navigationTo = PublishRelay<Void>()
}
