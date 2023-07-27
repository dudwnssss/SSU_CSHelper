//
//  AuthRepository.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/31.
//

import Moya

enum AuthService {
    case signup(email: String, name: String, password: String)
    case login(email: String, password: String)
}

extension AuthService: BaseTargetType {
    
    var headers: [String: String]? {
        switch self {
        case .login:
            return [
                "Content-Type": "application/json"
            ]
        case .signup:
            return [
                "Content-Type": "application/json",
            ]
        }
    }

    var path: String {
        switch self {
        case .signup:
            return "/api/auth/sign-up"
        case .login:
            return "/api/auth/login"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signup:
            return .post
        case .login:
            return .post
        }
    }

    var task: Task {
        switch self {
        case let .login(email, password):
            return .requestParameters(
                parameters: ["email": email, "password": password],
                encoding: JSONEncoding.default
            )
        case let .signup(email, name, password):
            return .requestParameters(
                parameters: ["email": email, "name": name,  "password": password],
                encoding: JSONEncoding.default
            )
        
        default:
            return .requestPlain
        }
    }
}
