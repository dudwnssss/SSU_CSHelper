//
//  ChatViewModel.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class ChatViewModel{
    var chatList = BehaviorRelay<[Chat]>(value: [])
    var searchButtonTap = PublishRelay<String>()
    let disposeBag = DisposeBag()
    var chat = PublishSubject<ChatResponse>()

    
    init() {
        bind()
    }
}

extension ChatViewModel {
    
    func bind() {
        searchButtonTap
            .bind(with: self) { owner, value in
                let question = Chat(chat: value, isAnswer: false)
                owner.chatList.accept(owner.chatList.value + [question])
                owner.question(query: value)
            }.disposed(by: disposeBag)
        chat
            .subscribe(with: self) { owner, value in
                let answer = Chat(chat: value.answer, isAnswer: true)
                owner.chatList.accept(owner.chatList.value + [answer])
            }
            .disposed(by: disposeBag)
    }
    
    func question(query: String){
        let provider = MoyaProvider<AdviceSerice>(plugins: [NetworkLogPlugin()])
        let question = QuestionRequest(adviceId: 2, sentence: query)
        provider.request(.question(parameters: question)){ result in
            switch result {
            case .success(let response):
                do {
                    let chatResponse = try response.map(ChatResponse.self)
                    self.chat.onNext(chatResponse)
                } catch {
                    self.chat.onError(error)
                }
            case .failure(let error):
                self.chat.onError(error)
            }
        }
    }
    
}
