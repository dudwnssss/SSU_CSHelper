//
//  ChannelService.swift
//  CSHelper
//
//  Created by 임영준 on 2023/10/31.
//

import Moya
import UIKit

enum ChannelService{
    case history(channelId: Int)
}

extension ChannelService: BaseTargetType {
    
    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .history(let channelId):
            return "/api/channel/\(channelId)/advice"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .history:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .history:
            return .requestPlain

        }
    }
}
