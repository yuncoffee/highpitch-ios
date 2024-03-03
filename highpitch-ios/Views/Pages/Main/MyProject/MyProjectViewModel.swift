//
//  ProjectsViewModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/27/24.
//

import Foundation
import RxSwift
import RxCocoa

final class MyProjectViewModel: ViewModelType {
    let projects = BehaviorRelay(value: [ProjectModel]())
    let sections = BehaviorRelay(value: [SectionOfProjectModel]())
    let navigationTo = PublishRelay<Void>()
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let click: ControlEvent<Void>
    }
    
    struct Output {
        let text: Driver<String>
    }
    func transform(input: Input) -> Output {
        let text = input.click
            .map { "Hello World!" }
            .asDriver(onErrorJustReturn: "")
        
        return Output(text: text)
    }
}
