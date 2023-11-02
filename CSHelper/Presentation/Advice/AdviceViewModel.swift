//
//  AdviceViewModel.swift
//  CSHelper
//
//  Created by 임영준 on 2023/10/31.
//

import Foundation

import Moya
import RxSwift
import RxCocoa

class AdviceViewModel {
    
    var advice: AdviceResponse? {
        didSet {
            fetchChatHistory()
        }
    }
    
    var adviceSate = PublishSubject<Status>()
    var searchButtonTap = PublishRelay<String>()
    var chat = PublishSubject<ChatResponse>()
    var chatHistory = BehaviorSubject<[ChatResponse]>(value: [])
    var chatList = BehaviorRelay<[Chat]>(value: [])
    let disposeBag = DisposeBag()
    let state = PublishSubject<Void>()
    
    init() {
        bind()
    }
}

extension AdviceViewModel {
    
    func bind() {
        chatHistory
            .subscribe(with: self) { owner, value in
                var chatList: [Chat] = []
                value.forEach { response in
                    let question = Chat(chat: response.question, isAnswer: false)
                    let answer = Chat(chat: response.answer, isAnswer: true)
                    chatList.append(question)
                    chatList.append(answer)
                }
                owner.chatList.accept(chatList)
            }
            .disposed(by: disposeBag)
        
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
    
    
    func fetchChatHistory() {
        let provider = MoyaProvider<AdviceSerice>(plugins: [NetworkLogPlugin()])
        provider.request(.fetch(adviceId: advice!.adviceId)){ result in
            switch result {
            case .success(let response):
                do {
                    let chatResponse = try response.map([ChatResponse].self)
                    self.chatHistory.onNext(chatResponse)
                } catch {
                    self.chatHistory.onError(error)
                }
            case .failure(let error):
                self.chatHistory.onError(error)
            }
        }
    }
    
    func question(query: String){
        let provider = MoyaProvider<AdviceSerice>(plugins: [NetworkLogPlugin()])
        let question = QuestionRequest(adviceId: advice!.adviceId, sentence: query)
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
    
    func setState(adviceId: Int, status: String){
        let provider = MoyaProvider<AdviceSerice>(plugins: [NetworkLogPlugin()])
        let status = StatusRequest(adviceId: adviceId, status: status)
        provider.request(.status(parameters: status)){ [weak self] result in
            switch result {
            case .success(_):
                self?.state.onNext(())
            case .failure(let error):
                self?.state.onError(error)
            }
        }
    }
}
