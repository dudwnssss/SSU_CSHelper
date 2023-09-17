//
//  HistoryViewModel.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import Foundation

class ProfileViewModel{
    
    var profile: [Profile] = [Profile(name: "윤석민", role: "담당업무 | 학생 응대", department: "소속 | 소프트웨어학부 학부사무실")]
    var historyList: [History] = [History(name: "김민근", identifier: "12341234", summary: "똥마려워요", date: "3시간 전", isEnd: true),
                                  History(name: "송현섭", identifier: "23452345", summary: "배고파요", date: "어제", isEnd: false),
                                  History(name: "임영준", identifier: "3432234", summary: "졸려요", date: "9월 16일", isEnd: false),
                                  History(name: "박동진", identifier: "123112312", summary: "졸려요", date: "9월 15일", isEnd: true)]
    
}
