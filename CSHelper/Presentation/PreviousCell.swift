//
//  CompleteButtonCell.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/20.
//

import UIKit

final class PreviousCell: UITableViewCell {
   
    let historyTextView = UITextView().then{
        $0.text = "이전 질문입니다"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.layer.borderWidth = 1
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 5, bottom: 0, right: 5)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 4
        $0.isEditable = false
        $0.isUserInteractionEnabled = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLayout(){
        contentView.addSubview(historyTextView)
        historyTextView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            contentView.layer.borderWidth = 2
            contentView.layer.borderColor = UIColor.ohsogo_Blue?.cgColor
            contentView.layer.cornerRadius = 4

        } else {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.lightGray.cgColor
            contentView.layer.cornerRadius = 4

        }
    }
    
    
    
}

//#if DEBUG
//
//import SwiftUI
//
//struct PreviousCell_Previews: PreviewProvider {
//    static var previews: some View {
//        previousCell(frame: <#CGRect#>).getPreview()
//            .previewLayout(.fixed(width: 200, height: 100))
//    }
//}
//
//#endif
