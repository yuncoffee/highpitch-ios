//
//  AuthService.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/29/24.
//

import Foundation

final class AuthService {
    private let apiClient = APIClient.shared
    
    func signUp(request: SignUpRequest, completion: @escaping (Result<SignUpResponse, Error>) -> Void) {
        apiClient.signUp(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signIn(request: SignInRequset, completion: @escaping (Result<SignInResponse, Error>) -> Void) {
        apiClient.signIn(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
