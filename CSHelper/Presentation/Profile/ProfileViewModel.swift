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
    
    var name = BehaviorRelay<String>(value: "")
    var studentId = BehaviorRelay<String>(value: "")
    
    var adviceList = BehaviorSubject<[ChannelResponse]>(value: [])
    var advice = PublishSubject<AdviceResponse>()
    var existAdvice = PublishSubject<AdviceResponse>()
    var deleteAdvice = PublishSubject<Void>()
    
    init(){
        fetchAdvices()
    }
}

extension ProfileViewModel {
    
    func fetchAdvices(){
        let provider = MoyaProvider<ChannelService>(plugins: [NetworkLogPlugin()])
        provider.request(.history(channelId: 1)){ result in
            switch result {
            case .success(let response):
                do {
                    let channelResponses = try response.map([ChannelResponse].self)
                    self.adviceList.onNext(channelResponses)
                } catch {
                    self.adviceList.onError(error)
                }
            case .failure(let error):
                self.adviceList.onError(error)
            }
        }
    }
    
    func createAdvice(){
        let provider = MoyaProvider<AdviceSerice>(plugins: [NetworkLogPlugin()])
        provider.request(.create(parameters: CreateRequest(channelId: 1, name: name.value, studentId: studentId.value))) { result in
            switch result {
            case .success(let success):
                do  {
                    let response = try success.map(AdviceResponse.self)
                    self.advice.onNext(response)
                    self.fetchAdvices()
                } catch {
                    self.advice.onError(error)
                }
            case .failure(let error):
                self.advice.onError(error)
            }
        }
    }
    
    func fetchInfo(id: Int) {
        let provider = MoyaProvider<AdviceSerice>(plugins: [NetworkLogPlugin()])
        provider.request(.info(adviceId: id)){ result in
            switch result {
            case .success(let response):
                do {
                    let adviceResponse = try response.map(AdviceResponse.self)
                    self.existAdvice.onNext(adviceResponse)
                } catch {
                    self.existAdvice.onError(error)
                }
            case .failure(let error):
                self.existAdvice.onError(error)
            }
        }
    }
    
    func deleteAdvice(idx: Int) {
        do {
            let adviceId = try adviceList.value()[idx].adviceId
            let provider = MoyaProvider<AdviceSerice>(plugins: [NetworkLogPlugin()])

            provider.request(.delete(adviceId: adviceId)){ [weak self] result in
                switch result {
                case .success(_):
                    self?.fetchAdvices()
                case .failure(let error):
                    print(error)
                }
            }
        }catch {
            print("error")
        }
    }
    
}
