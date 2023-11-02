//
//  ProfileVie.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import UIKit

class ProfileView: BaseView{
    
    weak var delegate: NewAdviceProtocol?
    weak var delegateDelete: DeleteAdviceProtocol?
    
    let newAdivceAlert = UIAlertController(title: "고객정보를 입력하세요", message: nil, preferredStyle: .alert)
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private func createLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.55))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
                
                return section
                
            case 1:
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(94))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
//                header.pinToVisibleBounds = true
                
                var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
                configuration.showsSeparators = false
                
                configuration.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath -> UISwipeActionsConfiguration? in
                    return UISwipeActionsConfiguration(actions: [.init(style: .destructive, title: "삭제", handler: { action, view, completionHandler in
                        self?.delegateDelete?.deleteAdvice(idx: indexPath.item)
                        completionHandler(true)
                    })])
                }
                
                let section = NSCollectionLayoutSection.list(using: configuration,
                                                             layoutEnvironment: layoutEnvironment)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 16, bottom: 10, trailing: 16)
                section.boundarySupplementaryItems = [header]
                
                return section
            default:
                return nil
            }
            
        }
        return layout
    }
    
    override func setProperties() {
        collectionView.do {
            $0.backgroundColor = .systemGray6
            $0.register(cell: ProfileCell.self)
            $0.register(cell: HistoryCell.self)
            $0.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.reuseIdentifier)
        }
        newAdivceAlert.do {
            $0.addTextField {
                $0.placeholder = "이름을 입력해주세요"
                $0.borderStyle = .roundedRect
            }
            $0.addTextField {
                $0.placeholder = "학번을 입력해주세요"
                $0.borderStyle = .roundedRect
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            let confirm = UIAlertAction(title: "상담시작", style: .default, handler: { [weak self] _ in
                self?.delegate?.createNewAdvice()
            })
            $0.addAction(confirm)
            $0.addAction(cancel)
        }
    }
    
    override func setLayouts() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

protocol NewAdviceProtocol: AnyObject {
    func createNewAdvice()
}

protocol DeleteAdviceProtocol: AnyObject {
    func deleteAdvice(idx: Int)
}
