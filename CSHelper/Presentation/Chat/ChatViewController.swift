//
//  ChatViewController.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/05.
//

import UIKit
import Moya

class ChatViewController: BaseViewController {
    
    let textView = UITextView(frame: CGRect.zero)
    let chatView = ChatView()
    let chatViewModel = ChatViewModel()
    var navigationTitle = "새로운 문의"
    override func loadView() {
        self.view = chatView
    }
    
    var chatEnd: (()->Void)?
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Chat>!

    override func setProperties() {
        navigationItem.title = navigationTitle
        chatView.searchBar.delegate = self
        view.keyboardLayoutGuide.followsUndockedKeyboard = true
        setDataSource()
        setSnapshot()
        setNavigationBar()
    }
    
    func setNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(memoButtonDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "상담종료", style: .plain, target: self, action: #selector(endButtonDidTap))
    }
    
    @objc func endButtonDidTap(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logout = UIAlertAction(title: "상담 완료", style: .default) { _ in
            self.chatEnd?()
            self.navigationController?.popViewController(animated: true)
        }
        let quit = UIAlertAction(title: "상담 미완료", style: .default) { _ in
            self.chatEnd?()
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(logout)
        alert.addAction(quit)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc func memoButtonDidTap(){
        let alertController = UIAlertController(title: "메모를 작성하세요\n\n\n\n", message: nil, preferredStyle: .alert)

        let cancelAction = UIAlertAction.init(title: "취소", style: .default) { (action) in
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(cancelAction)

        let saveAction = UIAlertAction(title: "저장", style: .default) { (action) in
            let enteredText = self.textView.text
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(saveAction)

        alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
        textView.cornerRadius = 4
        textView.backgroundColor = UIColor.white
        textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 5, bottom: 8, right: 5)
        alertController.view.addSubview(self.textView)

        self.present(alertController, animated: true, completion: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                let margin: CGFloat = 0
                let xPos = rect.origin.x + margin
                let yPos = rect.origin.y + 54
                let width = rect.width - 2 * margin
                let height: CGFloat = 90

                textView.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
            }
        }
    }

}

extension ChatViewController {
    
    private func setSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Int, Chat>()
        snapshot.appendSections([0])
        snapshot.appendItems(chatViewModel.chattingList)
        dataSource.apply(snapshot)
    }
    
    private func setDataSource(){
        let cellRegistration = UICollectionView.CellRegistration<ChattingCell, Chat> { cell, indexPath, itemIdentifier in
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: chatView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.configureCell(chat: itemIdentifier)
            return cell
        })
    }
}


extension ChatViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        let question = Chat(chat: text, isAnswer: false)
        chatViewModel.chattingList.append(question)
        setSnapshot()
        
        chatView.loadingView.isHidden = false
        chatView.loadingView.indicator.startAnimating()
        
        SearchManager.shared.search(query: text) { [self] value in
            chatView.loadingView.indicator.stopAnimating()
            chatView.loadingView.isHidden = true
            let answer = Chat(chat: value.answer, isAnswer: true)
            self.chatViewModel.chattingList.append(answer)
            setSnapshot()
        }
        
        searchBar.text = ""
        
        print(chatViewModel.chattingList)
        searchBar.endEditing(true)
    }
}
