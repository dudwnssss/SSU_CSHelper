//
//  ChatView.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import UIKit

class ChatView: BaseView {
    
    let loadingView = LoadingView()
    let searchBar = UISearchBar()
    let emptyView = EmptyView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override func setProperties() {
        searchBar.do {
            $0.placeholder = "고객문의를 입력하세요"
        }

        collectionView.do {
            $0.keyboardDismissMode = .onDrag
        }
        
        loadingView.do {
            $0.isHidden = true
        }
    }
    
    private func createLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            return section
        }
        return layout
    }
    
    override func setLayouts() {
        addSubviews(searchBar, collectionView, loadingView, emptyView)
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.keyboardLayoutGuide.snp.top)
        }
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(searchBar.snp.top)
        }
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-60)
        }
    }
    
}
