//
//  AdviceRequest.swift
//  CSHelper
//
//  Created by 임영준 on 2023/10/31.
//

import Foundation

// MARK: - Empty
struct QuestionRequest: Encodable {
    let adviceId: Int
    let sentence: String
}

struct StatusRequest: Encodable {
    let adviceId: Int
    let status: Status.RawValue
}

struct CreateRequest: Encodable {
    let channelId: Int
    let name: String
    let studentId: String
}
