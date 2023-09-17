//
//  UIView+.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/12.
//

import UIKit

extension UIView{
    
    func addSubviews(_ views: UIView...) {
          for view in views {
              addSubview(view)
          }
      }
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}


#if DEBUG
import SwiftUI

extension UIView {
    private struct ViewRepresentable : UIViewRepresentable {
        
        let uiview : UIView
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
        }
        
        func makeUIView(context: Context) -> some UIView {
            return uiview
        }
    }
    func getPreview() -> some View {
        ViewRepresentable(uiview: self)
    }
}

#endif
