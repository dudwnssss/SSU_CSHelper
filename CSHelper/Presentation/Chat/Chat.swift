//
//  Chat.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import Foundation

struct Chat: Hashable{
    let id = UUID().uuidString
    let chat: String
    let isAnswer: Bool
}
