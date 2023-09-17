//
//  ProfileCell.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//


import UIKit

final class ProfileCell: UICollectionViewCell {
    
    let profileImageView = UIImageView().then{
        $0.backgroundColor = .lightGray
        $0.image = UIImage(named: "go")
        $0.contentMode = .scaleAspectFill
        $0.cornerRadius = 4
    }
    
    let nicknameLabel = UILabel().then{
        $0.text = "dudansthanswkd"
        $0.font = .boldSystemFont(ofSize: 18)
    }
    let idLabel = UILabel().then{
        $0.text = "@mikeannn"
        $0.font = .systemFont(ofSize: 14)
    }
    let descriptionLabel = UILabel().then{
        $0.text = "최대글자수최대글자수최대글자수최대글자수최대글자수최대글자수최대글자수최대글"
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 14)
    }
    let phoneLabel = UILabel()
    
    
    let profileEditButton = UIButton().then{
        $0.setImage(UIImage(systemName: "pencil"), for: .normal)
        $0.tintColor = .lightGray
    }
    
    
    @objc func profileEditButtonDidTap(){
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayouts(){
        contentView.addSubviews( profileImageView, nicknameLabel, idLabel, descriptionLabel, profileEditButton, phoneLabel)

        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.28)
            $0.height.equalTo(profileImageView.snp.width).multipliedBy(1.3)
            $0.centerY.equalToSuperview()
        }
        
        idLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(idLabel)
            $0.bottom.equalTo(idLabel.snp.top).offset(-10)
            }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(8)
            $0.leading.equalTo(idLabel)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.bottom.lessThanOrEqualTo(profileImageView.snp.bottom)
        }
        
        profileEditButton.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel.snp.trailing)
            $0.centerY.equalTo(nicknameLabel).offset(-2)
            $0.size.equalTo(24)
        }
        
        phoneLabel.snp.makeConstraints {
            $0.leading.equalTo(idLabel)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        
    }
    
    func setProperties(){
        contentView.cornerRadius = 16
        contentView.backgroundColor = .white
        phoneLabel.do {
            $0.text = "TEL | 02-820-0249"
            $0.font = .systemFont(ofSize: 14)
        }

    }
    
    func configureCell(profile: Profile){
        self.nicknameLabel.text = profile.name
        self.idLabel.text = profile.role
        self.descriptionLabel.text = profile.department
    }
}
