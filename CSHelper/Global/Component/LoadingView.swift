//
//  IndicatorVIew.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/16.
//

import UIKit

class LoadingView: BaseView{
    
    let loadingLabel = UILabel()
    let indicator = UIActivityIndicatorView()
    
    override func setProperties() {
        backgroundColor = .black.withAlphaComponent(0.5)
        loadingLabel.do {
            $0.textColor = .white
            $0.text = "문의내용을 분석중입니다.\n잠시만 기다려주세요"
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 14)
            $0.textAlignment = .center
        }
    }
    
    override func setLayouts() {
        addSubviews(indicator, loadingLabel)
        loadingLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        indicator.snp.makeConstraints {
            $0.centerX.equalTo(loadingLabel)
            $0.bottom.equalTo(loadingLabel.snp.top).offset(-20)
        }
    }
    
}
