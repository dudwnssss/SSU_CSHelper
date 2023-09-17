//
//  historyCell.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import UIKit
import SnapKit

class HistoryCell: UICollectionViewCell{
    
    let nameLabel = UILabel()
    let stateLabel = UILabel()
    let idLabel = UILabel()
    let summaryLabel = UILabel()
    let dateLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    
    func setProperties(){
        contentView.cornerRadius = 12
        contentView.backgroundColor = .white
        nameLabel.do {
            $0.text = "김민근"
            $0.font = .boldSystemFont(ofSize: 16)
        }
        stateLabel.do {
            $0.text = "상담진행중"
            $0.textColor = .white
            $0.cornerRadius = 4
            $0.font = .systemFont(ofSize: 14)
            $0.backgroundColor = .systemCyan
        }
        idLabel.do {
            $0.text = "20181234"
            $0.textColor = .lightGray
            $0.font = .systemFont(ofSize: 14)
        }
        summaryLabel.do {
            $0.text = "아 휴학하고싶은데 아아아 좀 시켜주세요 제발요 네?"
            $0.textColor = .lightGray
            $0.font = .systemFont(ofSize: 14)
        }
        dateLabel.do {
            $0.text = "10월 8일"
            $0.textColor = .lightGray
            $0.font = .systemFont(ofSize: 14)
        }

    }
    
    func setLayouts(){
        contentView.addSubviews(nameLabel, idLabel, summaryLabel, stateLabel, dateLabel)
        stateLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview().offset(-10)
        }
        idLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(nameLabel)
        }
        summaryLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(nameLabel)
        }
        dateLabel.snp.makeConstraints {
            $0.trailing.equalTo(stateLabel)
            $0.centerY.equalTo(summaryLabel)
        }
    }
    
    func configureCell(history: History){
        nameLabel.text = history.name
        idLabel.text = history.identifier
        summaryLabel.text = history.summary
        dateLabel.text = history.date
        stateLabel.backgroundColor = history.isEnd ? .lightGray : .systemGreen
        stateLabel.text = history.isEnd ? "상담완료" : "상담진행중"
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
