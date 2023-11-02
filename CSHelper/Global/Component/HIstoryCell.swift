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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        idLabel.text = nil
        summaryLabel.text = nil
        dateLabel.text = nil
        stateLabel.backgroundColor = nil
        stateLabel.text = nil
    }

    
    func configureCell(advice: ChannelResponse){
            nameLabel.text = advice.name
            idLabel.text = advice.studentId
            summaryLabel.text = advice.lastQuestion
            dateLabel.text = formatRelativeDate(from: advice.modifiedAt)
            stateLabel.backgroundColor = advice.status?.backgroundColor ?? .lightGray
            stateLabel.text = advice.status?.text ?? "상태없음"
        }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryCell {
    
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
            $0.textAlignment = .right
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
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(10)
        }
        idLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(nameLabel)
        }
        summaryLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(nameLabel)
            $0.trailing.lessThanOrEqualTo(dateLabel.snp.leading)
        }
        dateLabel.snp.makeConstraints {
            $0.trailing.equalTo(stateLabel)
            $0.centerY.equalTo(summaryLabel)
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func formatRelativeDate(from dateString: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime]
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        if let date = dateFormatter.date(from: dateString) {
            let currentDate = Date()
            print("current", currentDate)
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: currentDate)
            if let year = components.year, year > 0 {
                return "\(year)년 전"
            } else if let month = components.month, month > 0 {
                return "\(month)개월 전"
            } else if let day = components.day, day > 0 {
                if day == 1 {
                    return "어제"
                } else if day <= 7 {
                    return "\(day)일 전"
                } else {
                    return "\(dateFormatter.string(from: date))"
                }
            } else if let hour = components.hour, hour > 0 {
                return "\(hour)시간 전"
            } else if let minute = components.minute, minute > 0 {
                return "\(minute)분 전"
            } else {
                return "방금"
            }
        } else {
            return "날짜 변환 실패"
        }
    }
    
}
