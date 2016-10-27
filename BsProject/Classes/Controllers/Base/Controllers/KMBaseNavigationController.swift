//
//  KMBaseNavigationController.swift
//  BsProject
//
//  Created by wujianming on 16/10/19.
//  Copyright © 2016年 szteyou. All rights reserved.
//  基类导航控制器

import UIKit

class KMBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func baseInit() -> Void {
        // Pop Item
        let itemAppearance = UIBarButtonItem.appearance()
        itemAppearance.setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: 0, vertical: -64), for: .default)
        
        // Nav Item
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = UIColor.white
        appearance.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white,
                                          NSFontAttributeName : UIFont.systemFont(ofSize: 18.0)]
        
        // Nav Bar
        appearance.setBackgroundImage(UIImage.imageWithColor(color: UIColor.clear), for: .default)
        appearance.shadowImage = UIImage.imageWithColor(color: UIColor.clear)
        let image = UIImage.imageWithColor(color: UIColor.clear)
        appearance.backIndicatorImage = image
        appearance.backIndicatorTransitionMaskImage = image
    }
}
