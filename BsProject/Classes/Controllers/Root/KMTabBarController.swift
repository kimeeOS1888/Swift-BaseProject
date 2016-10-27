//
//  KMTabBarController.swift
//  BsProject
//
//  Created by wujianming on 16/10/19.
//  Copyright © 2016年 szteyou. All rights reserved.
//

import UIKit

class KMTabBarController: KMBaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    } 

    func commonInit() -> Void {
        let homeVc = KMHomePageController()
        let homeNav = KMNavigationController(rootViewController: homeVc)
        homeNav.tabBarItem = UITabBarItem.init(title: "首页",
                                               image: UIImage(named: "home")?.orginal(),
                                               selectedImage: UIImage(named: "home_select")?.orginal())
        
        let lastVc = KMLastPageController()
        let lastNav = KMNavigationController(rootViewController: lastVc)
        lastNav.tabBarItem = UITabBarItem.init(title: "发现",
                                               image: UIImage(named: "find")?.orginal(),
                                               selectedImage: UIImage(named: "find_select")?.orginal())
        
        self.viewControllers = [homeNav, lastNav]
        
        // 反射机制
        
        
        // 自定义字体
        for nav in self.viewControllers! {
            nav.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 11.0)], for: .normal)
            nav.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.colorWithHex(hex: 0xff0000), NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)], for: .selected)
            // 标题位移
            nav.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
            // 图片位移
            nav.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0)
        }
    }
}
