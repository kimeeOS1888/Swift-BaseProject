//
//  UIImage-Extension.swift
//  BsProject
//
//  Created by wujianming on 16/10/19.
//  Copyright © 2016年 szteyou. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static func imageWithColor(color: UIColor) -> UIImage {
        let aFrame = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(aFrame.size);
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(aFrame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!;
    }
    
    func orginal() -> UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
}
