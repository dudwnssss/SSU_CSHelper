//
//  ChatViewController.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/05.
//

import UIKit
import Moya

class ChatViewController: BaseViewController {
    
    let chatView = ChatView()
    let chatViewModel = ChatViewModel()
    
    override func loadView() {
        self.view = chatView
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Chat>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, Chat>()

    override func setProperties() {
        navigationItem.title = "송현섭님의 문의내역"
        chatView.searchBar.delegate = self
        navigationController?.navigationBar.backgroundColor = .systemCyan
        view.keyboardLayoutGuide.followsUndockedKeyboard = true
        setDataSource()
        setSnapshot()
    }

}

extension ChatViewController {
    
    private func setSnapshot(){
        snapshot.appendSections([0])
        snapshot.appendItems(chatViewModel.chattingList)
        dataSource.apply(snapshot)
    }
    
    private func setDataSource(){
        let cellRegistration = UICollectionView.CellRegistration<ChattingCell, Chat> { cell, indexPath, itemIdentifier in
//            cell.configureCell(chat: itemIdentifier)
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
        snapshot.appendItems(chatViewModel.chattingList)
        dataSource.apply(snapshot)
        
        SearchManager.shared.search(query: text) { [self] value in
            let answer = Chat(chat: value.answer, isAnswer: true)
            self.chatViewModel.chattingList.append(answer)
            snapshot.appendItems(self.chatViewModel.chattingList)
            dataSource.apply(snapshot)
        }
        
        print(chatViewModel.chattingList)
        searchBar.endEditing(true)
    }
}
