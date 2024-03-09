//
//  RecordingViewModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class RecordingViewModel {
    let projectName = BehaviorRelay(value: Date().description)
    let sections = BehaviorRelay(value: [SectionOfProjectModel]())
    let selectedIndexPath = BehaviorRelay<IndexPath?>(value: IndexPath(row: 0, section: 0))
    
    let disposeBag = DisposeBag()
}
