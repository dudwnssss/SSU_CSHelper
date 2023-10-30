//
//  BaseTargetType.swift
//  dandi
//
//  Created by 김윤서 on 2023/03/03.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType {}

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: "http://ec2-43-201-90-131.ap-northeast-2.compute.amazonaws.com:8080")!
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(UserDefaultHandler.shared.accessToken)"
        ]
    }

    var sampleData: Data {
        return Data()
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
