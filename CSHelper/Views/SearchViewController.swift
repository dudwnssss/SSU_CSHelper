//
//  SearchViewController.swift
//  CSHelper
//
//  Created by 임영준 on 2023/06/16.
//

import UIKit
import Moya

class SearchViewController: BaseViewController{
    
    let questionLabel = UILabel().then{
        $0.text = "질문"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    let answerLabel = UILabel().then{
        $0.text = "답변"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let searchButton = UIButton().then{
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
    }
    
    let logoutButton = UIButton().then{
        $0.setImage(UIImage(systemName: "door.left.hand.open"), for: .normal)
        $0.tintColor = .black
    }

    let questionTextView = UITextView().then{
        $0.textContainer.maximumNumberOfLines = 0
        $0.text = "질문 내용입니다"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.isEditable = false
    }
    let answerTextVIew = UITextView().then{
        $0.textContainer.maximumNumberOfLines = 0
        $0.layer.borderWidth = 1
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 4
        $0.text = "답변 내용입니다"
        $0.isEditable = false
    }
    
    let searchTextView = UITextView().then{
        $0.textContainer.maximumNumberOfLines = 0
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 4
        $0.sizeToFit()
    }
    
    let searchStackView = UIStackView().then{
        $0.axis = .horizontal
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
        title = "새로운 문의"
    }
    
    
    override func setLayouts(){
        self.view.addSubviews( questionLabel, questionTextView, answerLabel, answerTextVIew, searchTextView, searchButton)
        
        setNavigationBar()
        
        questionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(100)
        }
        questionTextView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }
        
        answerLabel.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.leading)
            $0.top.equalTo(questionTextView.snp.bottom).offset(20)
        }
        
        answerTextVIew.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
            $0.top.equalTo(answerLabel.snp.bottom).offset(10)
        }
                
        searchTextView.snp.makeConstraints {
            $0.bottom.equalTo(answerTextVIew).offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-5)
            $0.height.equalTo(30)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalTo(searchTextView.snp.centerY)
            $0.height.equalTo(30)
            $0.width.equalTo(40)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
    }
    
    override func setProperties() {
    }
    
    override func bind() {
        searchButton.rx.tap.bind{
            self.search()
        }.disposed(by: disposeBag)
        
        logoutButton.rx.tap.bind{
            UserDefaultHandler.shared.accessToken = ""
            RootSwitcher.update(.login)
        }.disposed(by: disposeBag)
        
    }
    
    func search(){
        let provider = MoyaProvider<SearchService>(plugins: [NetworkLogPlugin()])
        provider.request(.search(searchTextView.text)){ result in
            switch result {
            case let .success(response):
                if let result = try? response.map(SearchResult.self) {
                    DispatchQueue.main.async {
                        self.questionTextView.text = result.question
                        self.answerTextVIew.text = result.answer
                        print("하아아아")
                    }
                } else {
                    print("Mapping failed")
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}

#if DEBUG
import SwiftUI
import Moya

struct SearchViewController_Previews: PreviewProvider {
    static var previews: some View {
        let viewController = SearchViewController()
        return viewController.getPreview()
    }
}

#endif
