//
//  ProfileHeader.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/17.
//

import UIKit

final class ProfileHeader: UICollectionReusableView {
    
    let headerTitleLabel = UILabel().then{
        $0.text = "상담 내역"
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .gray
    }
    let projectCountLabel = UILabel().then{
        $0.text = "4"
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .gray
    }
    
    let newChatButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    var newChatDidTap: (()->Void)?
    
    @objc func newChatButtonDidTap(){
        newChatDidTap?()
    }
    
    func setProperties(){
        backgroundColor = .systemGray6
        newChatButton.do {
            $0.cornerRadius = 12
            $0.backgroundColor = .systemCyan.withAlphaComponent(0.8)
            $0.tintColor = .white
            $0.setTitle(" 새로운 상담 시작하기", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            $0.setTitleColor(.white, for: .normal)
            $0.setImage(UIImage(systemName: "phone.bubble.left.fill"), for: .normal)
            $0.addTarget(self, action: #selector(newChatButtonDidTap), for: .touchUpInside)
        }

    }
    
    func setLayouts(){
        addSubviews(headerTitleLabel, projectCountLabel, newChatButton)
        headerTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview()
        }
        projectCountLabel.snp.makeConstraints {
            $0.leading.equalTo(headerTitleLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(headerTitleLabel)
        }
        newChatButton.snp.makeConstraints {
            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
