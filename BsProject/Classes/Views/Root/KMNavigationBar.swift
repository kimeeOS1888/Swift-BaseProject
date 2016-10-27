//
//  KMNavigationBar.swift
//  BsProject
//
//  Created by wujianming on 16/10/19.
//  Copyright © 2016年 szteyou. All rights reserved.
//  保留NavigationBar所有功能，在其底层盖上一个显示的view

import UIKit

typealias leftItemBlock = () -> Void

class KMNavigationBar: UIView {
    
    var leftItem: UIButton!
    private var leftItemCallBack: leftItemBlock?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = UIColor.colorWithHexString(string: "F0F0F0", alpha: 1.0) // 默认背景色
        self.backgroundColor = UIColor.red
        
        leftItem = UIButton(type: UIButtonType.custom)
        leftItem.frame = CGRect(x: 10.0, y: 20.0, width: 60.0, height: 44.0)
        leftItem.contentHorizontalAlignment = .left
        self.addSubview(leftItem)
        
        leftItem.addTarget(self, action: #selector(self.leftItemAction), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func leftItemAction() -> Void {
        if leftItemCallBack != nil {
            leftItemCallBack!()
        }
    }
    
    func leftItemActionCompletion(block: leftItemBlock) -> Void {
        
    }
}
