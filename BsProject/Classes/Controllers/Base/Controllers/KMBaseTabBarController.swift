//
//  KMBaseTabBarController.swift
//  BsProject
//
//  Created by wujianming on 16/10/19.
//  Copyright © 2016年 szteyou. All rights reserved.
//  基类选项控制器

import UIKit

class KMBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func baseInit() -> Void {
        // 主题设置
        let appearance = UITabBar.appearance()
        appearance.tintColor = UIColor.black
    }
}
