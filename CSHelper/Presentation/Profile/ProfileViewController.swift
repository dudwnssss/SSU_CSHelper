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
        let history: ChannelResponse?
        init(profile: Profile? = nil, history: ChannelResponse? = nil) {
            self.profile = profile
            self.history = history
        }
    }
    
    let profileView = ProfileView()
    let viewModel = ProfileViewModel()
    
    override func loadView() {
        self.view = profileView
    }
    
    override func bind() {
        
        profileView.newAdivceAlert.textFields?[0].rx.text
            .orEmpty
            .bind(with: self) { owner, value in
                owner.viewModel.name.accept(value)
            }
            .disposed(by: disposeBag)
        
        profileView.newAdivceAlert.textFields?[1].rx.text
            .orEmpty
            .bind(with: self) { owner, value in
                owner.viewModel.studentId.accept(value)
            }
            .disposed(by: disposeBag)
                  
        viewModel.adviceList
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.setSnapshot()
            }.disposed(by: disposeBag)
        
        viewModel.advice
            .subscribe(with: self, onNext: { owner, value in
                owner.navigateToAdviceVC(advice: value)
            })
            .disposed(by: disposeBag)
        
        viewModel.existAdvice
            .subscribe(with: self) { owner, value in
                owner.navigateToAdviceVC(advice: value)
            }
            .disposed(by: disposeBag)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    
    override func setProperties() {
        setDataSource()
        setSnapshot()
        setNavigationBar()
        profileView.delegate = self
        profileView.delegateDelete = self
        profileView.collectionView.delegate = self
    }
    
    func setNavigationBar(){
        navigationItem.title = "프로필"
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
    
    func presentAlert(){
        let alert = profileView.newAdivceAlert
        alert.textFields?.forEach({ value in
            value.text = nil
        })
       present(alert, animated: true)
    }
    
    func navigateToAdviceVC(advice: AdviceResponse){
        let vc = AdviceViewController()
        vc.delegate = self
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.advice = advice
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
    private func setSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        let profileItem = viewModel.profile.map { Item(profile: $0)}
        snapshot.appendItems(profileItem, toSection: .profile)
        let historyItem = try! viewModel.adviceList.value().map { Item(history: $0)}
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
                cell.configureCell(advice: itemIdentifier.history!)
                return cell
            }
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.reuseIdentifier, for: indexPath) as? ProfileHeader else { return UICollectionReusableView() }
                        
            self.viewModel.adviceList
                .withUnretained(self)
                .subscribe { vc, value in
                    header.projectCountLabel.text = "\(value.count)"
                }.disposed(by: self.disposeBag)
            
            header.newChatButton.rx.tap.bind { [weak self] _ in
                self?.presentAlert()
            }.disposed(by: self.disposeBag)
            
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        do {
            let adviceId = try viewModel.adviceList.value()[indexPath.item].adviceId
            viewModel.fetchInfo(id: adviceId)
        } catch  {
            print("error")
        }
    }
    
}

extension ProfileViewController: NewAdviceProtocol {
    func createNewAdvice() {
        viewModel.createAdvice()
    }
}

extension ProfileViewController: AdviceEndProtocol {
    func adviceDidEnd() {
        viewModel.fetchAdvices()
        setSnapshot()
    }
}

extension ProfileViewController: DeleteAdviceProtocol {
    func deleteAdvice(idx: Int) {
        viewModel.deleteAdvice(idx: idx)
    }
}
