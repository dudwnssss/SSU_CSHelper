//
//  Profile.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import Foundation

struct Profile: Hashable {
    let id = UUID().uuidString
    let name: String
    let role: String
    let department: String
    
}
