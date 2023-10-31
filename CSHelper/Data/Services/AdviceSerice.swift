//
//  AdviceSerice.swift
//  CSHelper
//
//  Created by 임영준 on 2023/10/31.
//

import Moya

enum AdviceSerice {
    case create(parameters: CreateRequest)
    case fetch(adviceId: Int)
    case status(parameters: StatusRequest)
    case question(parameters: QuestionRequest)
}

extension AdviceSerice: BaseTargetType {
    
    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .create:
            return "/api/advice"
        case .status:
            return "/api/advice/status"
        case .fetch(let adviceId):
            return "/api/advice/\(adviceId)/question"
        case .question:
            return "/api/advice/question"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .status:
            return .post
        case .fetch:
            return .get
        case .question:
            return .post
        case .create:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .create(let request):
            return .requestJSONEncodable(request)
        case .question(let request):
            return .requestJSONEncodable(request)
        case .status(let request):
            return .requestJSONEncodable(request)
        default:
            return .requestPlain
        }
    }
    
}
