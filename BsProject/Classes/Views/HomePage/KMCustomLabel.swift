//
//  KMCustomLabel.swift
//  BsProject
//
//  Created by wujianming on 16/10/25.
//  Copyright © 2016年 szteyou. All rights reserved.
//

import UIKit

class KMCustomLabel: UILabel {

    override init(frame: CGRect) { // 纯代码入口
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) { // xib sb入口
        fatalError("init(coder:) has not been implemented")
    }
}
