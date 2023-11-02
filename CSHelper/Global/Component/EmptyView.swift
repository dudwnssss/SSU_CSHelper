//
//  EmptyView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import UIKit

final class EmptyView: BaseView {
    
    private let imageView = UIImageView()
    private let label = UILabel()
    
    override func setProperties() {
        imageView.do {
            $0.image = UIImage(systemName: "bubble.left.and.text.bubble.right.fill")
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .lightGray
        }

        label.do {
            $0.text = "고객 응대 도우미 CSHelper 입니다\n고객 문의를 입력해주세요"
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .lightGray
        }

    }
    override func setLayouts() {
        addSubviews(imageView, label)
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.size.equalTo(56)
        }
        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
    }
}
