//
//  KMBaseTextField.swift
//  BsProject
//
//  Created by wujianming on 16/10/20.
//  Copyright © 2016年 szteyou. All rights reserved.
//

import UIKit

@IBDesignable
class KMBaseTextField: UITextField {

    let textKey = "cacheText"
    
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
    
    func cacheText() -> Void {
        let uDefault = UserDefaults.standard
        uDefault.set(self.text, forKey: textKey)
        uDefault.synchronize()
    }
    
    func showCacheText() -> Void {
        let uDefault = UserDefaults.standard
        self.text = uDefault.object(forKey: textKey) as? String
    }
}
