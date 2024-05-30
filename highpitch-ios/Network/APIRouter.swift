//
//  APIRouter.swift
//  highpitch-ios
//
//  Created by yuncoffee on 5/29/24.
//

import Foundation

import Alamofire

enum APIRouter: URLRequestConvertible {
    case getUser
    case signIn(SignInRequset)
    case signUp(SignUpRequest)
    
    var method: HTTPMethod {
        switch self {
        case .getUser:
            return .get
        case .signIn, .signUp:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getUser:
            return APIEndpoints.user
        case .signIn:
            return APIEndpoints.signIn
        case .signUp:
            return APIEndpoints.signUp
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getUser:
            return nil
        case .signIn(let request):
            return try? request.asDictionary()
        case .signUp(let request):
            return try? request.asDictionary()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIEndpoints.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.method = method
        
        if let parameters = parameters {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dictionary
    }
}
