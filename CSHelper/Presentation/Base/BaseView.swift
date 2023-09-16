//
//  BaseView.swift
//  CSHelper
//
//  Created by 임영준 on 2023/09/05.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProperties(){}
    func setLayouts(){}
}
