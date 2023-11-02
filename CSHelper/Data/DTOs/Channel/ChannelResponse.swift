//
//  ChannelResponse.swift
//  CSHelper
//
//  Created by 임영준 on 2023/10/31.
//

import Foundation

// MARK: - Empty
struct ChannelResponse: Decodable, Hashable {
    let adviceId: Int
    let name: String
    let studentId: String
    let status: Status?
    let modifiedAt: String
    let lastQuestion: String
}
