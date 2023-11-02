//
//  AdviceResponse.swift
//  CSHelper
//
//  Created by 임영준 on 2023/10/31.
//

import Foundation

struct AdviceResponse: Decodable, Hashable {
    let adviceId: Int
    let name: String
    let memo: String?
    let studentId: String
    let status: Status?
    let modifiedAt: String
}
