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

        private let identifier = UUID()
    }
    
    
    let profileView = ProfileView()
    let profileViewModel = ProfileViewModel()
    
    override func loadView() {
        self.view = profileView
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    override func setProperties() {
        navigationItem.title = "프로필"
        setDataSource()
        setSnapshot()
    }
    
}

extension ProfileViewController {
    
    private func setSnapshot(){
        snapshot.appendSections(Section.allCases)
        let profileItem = profileViewModel.profile.map { Item(profile: $0)}
        var profileSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        
        let historyItem = profileViewModel.historyList.map { Item(history: $0)}
        var historySnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        

        profileSnapshot.append(profileItem)
        historySnapshot.append(historyItem)

        dataSource.apply(profileSnapshot, to: .profile)
        dataSource.apply(historySnapshot, to: .history)
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
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.reuseIdentifier, for: indexPath)
            return view
        }
    }
}
