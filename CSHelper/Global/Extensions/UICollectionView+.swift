////
////  UICollectionView+.swift
////  CSHelper
////
////  Created by 임영준 on 2023/09/17.
////
//
//import UIKit.UICollectionView
//
//extension UICollectionView {
//
//    func setEmptyView(title: String, message: String) {
//
//        let emptyView: UIView = {
//            let view = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.width, height: self.bounds.height))
//            return view
//        }()
//
//        let titleLabel: UILabel = {
//            let label = UILabel()
//            label.text = title
//            label.textColor = .darkGray
//            label.font = .boldSystemFont(ofSize: 16)
//            return label
//        }()
//
//        let messageLabel: UILabel = {
//            let label = UILabel()
//            label.text = message
//            label.textColor = .gray
//            label.font = .boldSystemFont(ofSize: 15)
//            label.numberOfLines = 0
//            label.textAlignment = .center
//            return label
//        }()
//
//
//        emptyView.addSubViews(titleLabel, messageLabel)
//
//        titleLabel.snp.makeConstraints {
//            $0.centerY.equalTo(emptyView.snp.centerY)
//            $0.centerX.equalTo(emptyView.snp.centerX)
//        }
//
//        messageLabel.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
//            $0.centerX.equalToSuperview()
//        }
//
//        self.backgroundView = emptyView
//
//    }
//
//    func restore() {
//        self.backgroundView = nil
//    }
//}
