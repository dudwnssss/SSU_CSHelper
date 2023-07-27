//
//  SearchService.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/06/03.
//

import Moya
import UIKit

enum SearchService{
    case search(String)
}

extension SearchService: BaseTargetType {
    
    var headers: [String: String]? {
        switch self {
        case .search:
            return [
                "Content-Type": "text/plain",
                "Authorization": "Bearer \(UserDefaultHandler.shared.accessToken)"
            ]
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaultHandler.shared.accessToken)"
            ]
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "/api/question/recommendation"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .search(let text):
            guard let data = text.data(using: .utf8) else {
                return .requestPlain
            }
            return .requestData(data)
        }
    }
}
