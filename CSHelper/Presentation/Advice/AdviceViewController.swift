//
//  AdviceViewController.swift
//  CSHelper
//
//  Created by 임영준 on 2023/10/31.
//

import UIKit
import RxSwift
import RxCocoa

protocol AdviceEndProtocol: AnyObject {
    func adviceDidEnd()
}

class AdviceViewController: BaseViewController {
    
    weak var delegate: AdviceEndProtocol?
    let adviceView = ChatView()
    let viewModel = AdviceViewModel()
    
    override func loadView() {
        self.view = adviceView
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Chat>!
    
    func setNavigationBar(){
        navigationItem.title = viewModel.advice!.name + "님과의 상담"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "상담종료", style: .plain, target: self, action: #selector(endButtonDidTap))
    }
    
    override func bind() {
        
        viewModel.chatList
            .bind(with: self) { owner, _ in
                owner.setSnapshot()
            }
            .disposed(by: disposeBag)
        
        viewModel.state
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
                owner.delegate?.adviceDidEnd()
            }
            .disposed(by: disposeBag)
    }
    
    override func setProperties() {
        adviceView.searchBar.delegate = self
        setNavigationBar()
        setDataSource()
        setSnapshot()
    }
    
    @objc func endButtonDidTap(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        guard let adviceId = viewModel.advice?.adviceId else { return }
        let logout = UIAlertAction(title: "상담 완료", style: .default) { [weak self] _ in
            let status = Status.completed.rawValue
            self?.viewModel.setState(adviceId: adviceId, status: status)
        }
        let quit = UIAlertAction(title: "상담 미완료", style: .default) { [weak self] _ in
            let status = Status.inProgress.rawValue
            self?.viewModel.setState(adviceId: adviceId, status: status)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(logout)
        alert.addAction(quit)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
}

extension AdviceViewController {
    
    private func setSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Int, Chat>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.chatList.value)
        dataSource.apply(snapshot)
    }
    
    private func setDataSource(){
        let cellRegistration = UICollectionView.CellRegistration<ChattingCell, Chat> { cell, indexPath, itemIdentifier in
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: adviceView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.configureCell(chat: itemIdentifier)
            return cell
        })
    }
    
}

extension AdviceViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#fileID, #function, #line, "- ")
        viewModel.searchButtonTap
            .accept(searchBar.text ?? "")
    }
}
