//
//  ProfileHeader.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/17.
//

import UIKit

final class ProfileHeader: UICollectionReusableView {
    
    let headerTitleLabel = UILabel().then{
        $0.text = "상담내역"
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .gray
    }
    let projectCountLabel = UILabel().then{
        $0.text = "4"
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .gray
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
    }
    
    func setLayouts(){
        addSubviews(headerTitleLabel, projectCountLabel)
        headerTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        projectCountLabel.snp.makeConstraints {
            $0.leading.equalTo(headerTitleLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(headerTitleLabel)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
