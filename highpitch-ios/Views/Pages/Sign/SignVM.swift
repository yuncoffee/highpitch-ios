//
//  SignVM.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/28/24.
//

import Foundation

import RxSwift
import RxCocoa

final class SignVM: ViewModelType {
    private let authService = AuthService()
    private let disposeBag = DisposeBag()

    let email = BehaviorRelay(value: "test11@naver.com")
    let username = BehaviorRelay(value: "test1234")
    let password = BehaviorRelay(value: "123456")
    
    struct Input {
        let signInButtonTap: ControlEvent<Void>?
        let signUpButtonTap: ControlEvent<Void>?
    }
    
    struct Output {
        let signUpResult = PublishRelay<String>()
        let signInResult = PublishRelay<String>()
    }
    
    func transform(input: Input) -> Output {
        input.signInButtonTap?
            .withUnretained(self)
            .subscribe { vm, _ in
                print("THIII YONG?")
            }
            .disposed(by: disposeBag)
        
        input.signUpButtonTap?
            .withLatestFrom(Observable.combineLatest(email, username, password))
            .withUnretained(self)
            .flatMapLatest { $0.authService.signUp(request: SignUpRequest(name: $1.0, username: $1.1, password: $1.2)) }
            .subscribe(onNext: { result in
                switch result {
                case .success(let response):
                    print("SUCCESS")
                    print(response.name)
                case .failure(let error):
                    print("FAIL")
                    print(error)
                }
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
    
    deinit {
        print("SignVM Deinit")
    }
}
