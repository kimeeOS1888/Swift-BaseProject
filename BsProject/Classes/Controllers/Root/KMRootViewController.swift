//
//  KMRootViewController.swift
//  BsProject
//
//  Created by wujianming on 16/10/23.
//  Copyright © 2016年 szteyou. All rights reserved.
//

import UIKit

class KMRootViewController: KMMainframeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftVc = KMLeftViewController()
        let rigthVc = KMTabBarController()
        leftVc.leftViewWidthScale = 0.6 // 左边视图占屏宽比
        
        self.leftViewController = leftVc
        self.rightViewController = rigthVc
        
        // 设置左边视图控制最大占据屏幕总宽度的比例
        self.leftViewControllerMaxScaleOfWidth = leftVc.leftViewWidthScale
        
        // 左边视图控制器刚开始展示的区域起始值占自身总宽度的比例
        self.leftViewControllerStartScaleOfWidth = self.leftViewControllerMaxScaleOfWidth * 0.5
        
        // 侧滑有效区
        self.rightViewControllerPanLocationX = 1 - self.leftViewControllerMaxScaleOfWidth
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 写在根控制器才起效
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
