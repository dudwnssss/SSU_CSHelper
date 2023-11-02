//
//  ChatResponse.swift
//  CSHelper
//
//  Created by 임영준 on 2023/11/01.
//

import Foundation

struct ChatResponse: Decodable {
    let historyId: Int
    let question, answer: String
    let accuracy: Double?
    let createdAt: String
}
