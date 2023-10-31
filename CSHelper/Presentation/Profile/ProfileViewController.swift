//
//  ProfileViewController.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    enum Section: Int, CaseIterable{
        case profile
        case history
    }
    struct Item: Hashable {
        let profile: Profile?
        let history: History?
        init(profile: Profile? = nil, history: History? = nil) {
            self.profile = profile
            self.history = history
        }
    }
    
    let profileView = ProfileView()
    let viewModel = ProfileViewModel()
    
    override func loadView() {
        self.view = profileView
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()


    override func setProperties() {
        navigationItem.title = "프로필"
        setDataSource()
        setSnapshot()
        setNavigationBar()
    }
    
    func setNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingButtonDidTap))
    }
    
    @objc func settingButtonDidTap(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logout = UIAlertAction(title: "로그아웃", style: .default)
        let quit = UIAlertAction(title: "탈퇴하기", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(logout)
        alert.addAction(quit)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension ProfileViewController {
    
    private func setSnapshot(){
        snapshot.appendSections(Section.allCases)
        let profileItem = viewModel.profile.map { Item(profile: $0)}
        let historyItem = viewModel.historyList.map { Item(history: $0)}
        snapshot.appendItems(profileItem, toSection: .profile)
        snapshot.appendItems(historyItem, toSection: .history)
        dataSource.apply(snapshot)
    }
    
    private func setDataSource(){
        self.dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: profileView.collectionView) {(collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError() }
            switch section {
            case .profile:
                let cell: ProfileCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configureCell(profile: itemIdentifier.profile!)
                return cell
            case .history:
                let cell: HistoryCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configureCell(history: itemIdentifier.history!)
                return cell
            }
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.reuseIdentifier, for: indexPath) as? ProfileHeader else {return UICollectionReusableView()}
            return header
        }
    }
}
