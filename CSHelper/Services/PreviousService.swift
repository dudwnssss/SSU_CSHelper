//
//  SearchService.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/06/03.
//

import Moya
import UIKit

enum PreviousService{
    case previous
}

extension PreviousService: BaseTargetType {
    
    var path: String {
        switch self {
        case .previous:
            return "/api/question/history"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .previous:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .previous:
            return .requestPlain

        }
    }
}
