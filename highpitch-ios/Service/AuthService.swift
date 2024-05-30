//
//  AuthService.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/29/24.
//

import Foundation

import RxSwift
import Alamofire

final class AuthService {
    private let apiClient = APIClient.shared
    
    // MARK: - 회원가입
    func signUp(request: SignUpRequest) -> Observable<Result<UserResponse, APIFailureResponse>> {
        Observable.create { observer in
            self.apiClient.signUp(request: request) { result in
                observer.onNext(result)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    // MARK: - 로그인
    func signIn(request: SignInRequset) -> Observable<Result<SignInResponse, AFError>> {
        Observable.create { observer in
            self.apiClient.signIn(request: request) { result in
                observer.onNext(result)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
