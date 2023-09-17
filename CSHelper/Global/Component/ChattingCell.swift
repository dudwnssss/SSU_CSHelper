//
//  ChattingCell.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/05.
//

import UIKit
import SnapKit

enum ChatType{
    case question
    case answer
    
    var bgColor: UIColor{
        switch self {
        case .question:
            return .systemGray
        case .answer:
            return .systemCyan
        }
    }
}

class ChattingCell: UICollectionViewCell{
    
    var chatType: ChatType?
    
    let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    func setLayouts(){
        contentView.addSubview(textView)
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setProperties(){
        textView.do {
            $0.isEditable = false
            $0.font = .boldSystemFont(ofSize: 16)
            $0.isScrollEnabled = false
            $0.textColor = .white
            $0.layer.cornerRadius = 10
            $0.backgroundColor = chatType?.bgColor
            $0.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    
    func configureCell(chat: Chat){
        textView.text = chat.chat
        textView.backgroundColor = chat.isAnswer ? .systemCyan : .systemGray5
        textView.textColor = chat.isAnswer ? .white : .black
        textView.snp.makeConstraints {
            $0.height.equalTo(textView.text.getEstimatedFrame(with: .boldSystemFont(ofSize: 16)).height+20)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = nil
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
