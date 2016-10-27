//
//  KMBaseButton.swift
//  BsProject
//
//  Created by wujianming on 16/10/20.
//  Copyright © 2016年 szteyou. All rights reserved.
//

import UIKit

@IBDesignable
class KMBaseButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor() {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
