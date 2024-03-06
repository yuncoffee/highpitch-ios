//
//  ProjectDetailViewModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/5/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ProjectDetailViewModel: ViewModelType {
    var project: ProjectModel?
    var currentTab: ProjectDetailViewTabs = .practices {
        didSet {
            print(currentTab)
        }
    }
    let disposeBag = DisposeBag()

    struct Input {
        let segmentedControlTap: ControlEvent<Void>
    }
    
    struct Output {
        let segmentedControlTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        Output(segmentedControlTap: input.segmentedControlTap)
    }
}

enum ProjectDetailViewTabs {
    case summary
    case practices
}
