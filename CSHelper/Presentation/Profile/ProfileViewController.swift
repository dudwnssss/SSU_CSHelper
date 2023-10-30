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
    var historySnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
    lazy var historyItem = profileViewModel.historyList.map { Item(history: $0)}


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
        let profileItem = profileViewModel.profile.map { Item(profile: $0)}
        var profileSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        
        

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
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.reuseIdentifier, for: indexPath) as? ProfileHeader else {return UICollectionReusableView()}
            header.newChatDidTap  = { [weak self] in
                let alert = UIAlertController(title: "고객정보를 입력하세요", message: nil, preferredStyle: .alert)
                alert.addTextField {
                    $0.placeholder = "이름을 입력해주세요"
                    $0.borderStyle = .roundedRect
                }
                alert.addTextField {
                    $0.placeholder = "학번을 입력해주세요"
                    $0.borderStyle = .roundedRect
                }
                let cancel = UIAlertAction(title: "취소", style: .cancel)
                let confirm = UIAlertAction(title: "시작", style: .default) { _ in
                    let vc = ChatViewController()
                    vc.chatEnd = {
                        
                    }
                    vc.hidesBottomBarWhenPushed = true
                    vc.navigationTitle = alert.textFields![0].text!+"님과의 상담"
                    vc.chatEnd = { [weak self] in
                        let newHistory = History(name: "신민석", identifier: "20181234", summary: "취업이 됐습니다. 남은 학점은 어떻게 하나요?", date: "지금", isEnd: false)
                        self?.profileViewModel.historyList.insert(newHistory, at: 0)
                        
                        let newItem = (self?.profileViewModel.historyList.first.map{Item(history: $0)}!)!
                        
//                        self?.historyItem.append(newItem)
                        guard let firstItem = self?.historyItem.first else {return}
                        self?.historySnapshot.insert([newItem], before: firstItem)
//                        self?.historySnapshot.append([newItem])
                        self?.dataSource.apply(self!.historySnapshot, to: .history)
                    }
                    
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                alert.addAction(cancel)
                alert.addAction(confirm)
                self?.present(alert, animated: true)
            }
            return header
        }
    }
}
