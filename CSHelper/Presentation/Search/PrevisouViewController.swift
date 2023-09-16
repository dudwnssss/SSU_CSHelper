//
//  SearchViewController.swift
//  CSHelper
//
//  Created by 임영준 on 2023/06/16.
//

import UIKit

class PreviousViewController: BaseViewController{
    
    var questionList : [Previous] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let provider = MoyaProvider<PreviousService>(plugins: [NetworkLogPlugin()])
        provider.request(.previous){ result in
            switch result {
            case let .success(response):
                if let result = try? response.map([Previous].self) {
                    self.questionList = Array(result.prefix(5))
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private(set) lazy var tableView = UITableView().then{
        $0.register(PreviousCell.self, forCellReuseIdentifier: "previousCell")
        $0.delegate = self
        $0.dataSource = self
    }
    
    let questionLabel = UILabel().then{
        $0.text = "질문"
        $0.font = UIFont.boldSystemFont(ofSize: 16)

    }
    let answerLabel = UILabel().then{
        $0.text = "답변"
        $0.font = UIFont.boldSystemFont(ofSize: 16)

    }
    
    let logoutButton = UIButton().then{
        $0.setImage(UIImage(systemName: "door.left.hand.open"), for: .normal)
        $0.tintColor = .black
    }
    
    let previousLabel = UILabel().then{
        $0.text = "문의 내역"
        $0.font = UIFont.boldSystemFont(ofSize: 16)

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
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 4
        $0.text = "답변 내용입니다"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        $0.isEditable = false
    }
    
    let searchTextView = UITextView().then{
        $0.textContainer.maximumNumberOfLines = 0
        $0.layer.borderWidth = 1
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
        title = "문의 내역"
    }
    
    override func bind() {
        logoutButton.rx.tap.bind{
            UserDefaultHandler.shared.accessToken = ""
            RootSwitcher.update(.login)
        }.disposed(by: disposeBag)
    }
    
    override func setLayouts(){
        self.view.addSubviews(questionLabel, questionTextView, answerLabel, answerTextVIew, previousLabel, tableView )
        
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
        
        previousLabel.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.leading)
            $0.top.equalTo(answerTextVIew.snp.bottom).offset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(previousLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    override func setProperties() {
        setNavigationBar()
    }
    
}

extension PreviousViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "previousCell", for: indexPath) as! PreviousCell
        cell.historyTextView.text = questionList[indexPath.row].question
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        questionTextView.text = questionList[indexPath.row].question
        answerTextVIew.text = questionList[indexPath.row].answer
    }
    
    
}


#if DEBUG
import SwiftUI
import Moya

struct PreviousViewController_Previews: PreviewProvider {
    static var previews: some View {
        let viewController = PreviousViewController()
        return viewController.getPreview()
    }
}

#endif
