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
    let viewModel = ChatViewModel()
    var navigationTitle = "새로운 문의"
    override func loadView() {
        self.view = chatView
    }
        
    var dataSource: UICollectionViewDiffableDataSource<Int, Chat>!

    override func setProperties() {
        navigationItem.title = navigationTitle
        chatView.searchBar.delegate = self
        view.keyboardLayoutGuide.followsUndockedKeyboard = true
        setDataSource()
        setSnapshot()
    }
    
    override func bind() {
        viewModel.chatList.bind(with: self) { owner, list in
            owner.chatView.loadingView.indicator.stopAnimating()
            owner.chatView.loadingView.isHidden = true
            owner.setSnapshot()
            owner.chatView.collectionView.scrollToItem(at: IndexPath(item: list.count - 1, section: 0), at: .bottom, animated: true)
            owner.chatView.emptyView.isHidden = !list.isEmpty
        }
        .disposed(by: disposeBag)
    }

}

extension ChatViewController {
    
    private func setSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Int, Chat>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.chatList.value)
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


extension ChatViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        chatView.loadingView.isHidden = false
        chatView.loadingView.indicator.startAnimating()
        viewModel.searchButtonTap
            .accept(searchBar.text ?? "")
        searchBar.text = nil
        searchBar.endEditing(true)
    }
}
