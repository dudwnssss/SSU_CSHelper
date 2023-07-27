//
//  SearchResult.swift
//  CSHelper
//
//  Created by 임영준 on 2023/06/17.
//


import Foundation

// MARK: - Welcome
struct SearchResult: Decodable {
    let id: Int
    let answer, question: String
    let accuracy: Double
    let createdAt: String
}
