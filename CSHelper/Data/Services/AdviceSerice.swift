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
    case info(adviceId: Int)
    case delete(adviceId: Int)
}

extension AdviceSerice: BaseTargetType {
    
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
        case .info(let adviceId):
            return "/api/advice/\(adviceId)"
        case .delete(let adviceId):
            return "/api/advice/\(adviceId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .status:
            return .put
        case .fetch:
            return .get
        case .question:
            return .post
        case .create:
            return .post
        case .info:
            return .get
        case .delete:
            return .delete
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
