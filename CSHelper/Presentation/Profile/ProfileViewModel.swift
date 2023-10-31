//
//  HistoryViewModel.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class ProfileViewModel{
    
    var profile: [Profile] = [Profile(name: "윤석민", role: "담당업무 | 학생 응대", department: "소속 | 소프트웨어학부 학부사무실")]
    var historyList: [History] = [History(name: "김민근", identifier: "12341234", summary: "이번학기 ICT인턴쉽을 진행중입니다. 6학점이 남은 상황인데 졸업을 하려면", date: "3시간 전", isEnd: true),
                                  History(name: "송현섭", identifier: "23452345", summary: "숭실 사이버대 강의를 들어도 학점인정이 되는 지 궁금합니다.", date: "어제", isEnd: false),
                                  History(name: "임영준", identifier: "3432234", summary: "이번학기를 휴학하고 다음학기에 복학예정입니다. 졸업시기는 어떻게 되는 건가요?", date: "9월 16일", isEnd: false),
                                  History(name: "박동진", identifier: "123112312", summary: "4학년인데 채플을 다 듣지 못했습니다. 졸업학기에 채플신청을 하려면 어떻게 해야하나", date: "9월 15일", isEnd: true)]
    
}
