//
//  AdviceStatus.swift
//  CSHelper
//
//  Created by 임영준 on 2023/10/31.
//

import UIKit

enum Status: String, Codable {
    case inProgress = "IN_PROGRESS"
    case completed = "COMPLETED"
    
    var backgroundColor: UIColor {
        switch self {
        case .inProgress:
            return .green
        case .completed:
            return .lightGray
        }
    }
    
    var text: String {
        switch self {
        case .inProgress:
            return "상담진행중"
        case .completed:
            return "상담완료"
        }
    }
}

