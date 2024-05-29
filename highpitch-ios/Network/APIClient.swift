//
//  APIClient.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/29/24.
//

import Foundation

import Alamofire

final class APIClient {
    static let shared = APIClient()
    private init() {}
    
    // getUser
    func getUsers(completion: @escaping (Result<[UserDTO], AFError>) -> Void) {
        AF.request(APIRouter.getUsers)
            .responseDecodable(of: [UserDTO].self) { response in
                completion(response.result)
            }
    }
    // getInfo
    
    // 로그인 요청
    func signIn(request: SignInRequset, completion: @escaping (Result<SignInResponse, AFError>) -> Void) {
        AF.request(APIRouter.signIn(request))
            .responseDecodable(of: SignInResponse.self) { response in
                completion(response.result)
            }
    }
    
    // 회원가입 요청
    func signUp(request: SignUpRequest, completion: @escaping (Result<SignUpResponse, AFError>) -> Void) {
        AF.request(APIRouter.signUp(request))
            .responseDecodable(of: SignUpResponse.self) { response in
                completion(response.result)
            }
    }
}
