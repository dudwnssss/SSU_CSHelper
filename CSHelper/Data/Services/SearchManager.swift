//
//  SearchManager.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import Foundation
import Moya

class SearchManager{
    
    static let shared = SearchManager()
    private init() {}
    
    func search(query: String, completion: @escaping (SearchResult) -> Void){
        let provider = MoyaProvider<SearchService>(plugins: [NetworkLogPlugin()])
        provider.request(.search(query)){ result in
            switch result {
            case let .success(response):
                if let result = try? response.map(SearchResult.self) {
                    completion(result)
                } else {
                    print("Mapping failed")
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
