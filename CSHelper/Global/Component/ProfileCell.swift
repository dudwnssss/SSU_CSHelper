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
        $0.font = .boldSystemFont(ofSize: 17)
    }
    let roleLabel = UILabel().then{
        $0.text = "@mikeannn"
        $0.font = .systemFont(ofSize: 14)
    }
    let descriptionLabel = UILabel().then{
        $0.text = "최대글자수최대글자수최대글자수최대글자수최대글자수최대글자수최대글자수최대글"
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 14)
    }
    let phoneLabel = UILabel()
    let logoImageView = UIImageView()
    
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
        contentView.addSubviews( profileImageView, nicknameLabel, roleLabel, descriptionLabel, profileEditButton, phoneLabel, logoImageView)

        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.28)
            $0.height.equalTo(profileImageView.snp.width).multipliedBy(1.3)
            $0.centerY.equalToSuperview()
        }
        
        roleLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView).offset(8)
            $0.leading.equalTo(roleLabel)
            }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(roleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(roleLabel)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.bottom.lessThanOrEqualTo(profileImageView.snp.bottom)
        }
        
        profileEditButton.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel.snp.trailing)
            $0.centerY.equalTo(nicknameLabel).offset(-2)
            $0.size.equalTo(24)
        }
        
        phoneLabel.snp.makeConstraints {
            $0.leading.equalTo(roleLabel)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        logoImageView.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
        }
        
        
    }
    
    func setProperties(){
        contentView.cornerRadius = 12
        contentView.backgroundColor = .white
        phoneLabel.do {
            $0.text = "TEL | 02-820-0249"
            $0.font = .systemFont(ofSize: 14)
        }
        logoImageView.do {
            $0.image = Image.soongsil
            $0.contentMode = .scaleAspectFill
        }


    }
    
    func configureCell(profile: Profile){
        self.nicknameLabel.text = profile.name
        self.roleLabel.text = profile.role
        self.descriptionLabel.text = profile.department
    }
}
