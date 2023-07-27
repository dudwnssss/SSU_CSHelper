//
//  PreviousResult.swift
//  CSHelper
//
//  Created by 임영준 on 2023/06/18.
//

import Foundation

// MARK: - WelcomeElement
struct Previous: Codable {
    let id: Int
    let answer, question: String
    let accuracy: Double
    let createdAt: String
}

//typealias Previous = [PreviousElement]
