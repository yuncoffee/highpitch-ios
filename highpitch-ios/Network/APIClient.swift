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
    func getUser(completion: @escaping (Result<UserResponse, AFError>) -> Void) {
        AF.request(APIRouter.getUser)
            .responseDecodable(of: UserResponse.self) { response in
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
    func signUp(request: SignUpRequest, completion: @escaping (Result<UserResponse, APIFailureResponse>) -> Void) {
        AF.request(APIRouter.signUp(request))
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    if let data = response.data {
                        do {
                            let error = try JSONDecoder().decode(APIFailureResponse.self, from: data)
                            completion(.failure(error))
                        } catch {
                            let genericError = APIFailureResponse(timestamp: Date().description, status: 400, error: "Catch Error", path: "App")
                            completion(.failure(genericError))
                        }
                    } else {
                        let unknownError = APIFailureResponse(timestamp: Date().description, status: 400, error: "Unknown Error", path: "App")
                        completion(.failure(unknownError))
                    }
                }
                
            }
    }
}
