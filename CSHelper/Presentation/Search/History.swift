//
//  History.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import Foundation

struct History: Hashable{
    let id = UUID().uuidString
    let name: String
    let identifier: String
    let summary: String
    let date: String
    let isEnd: Bool
}
