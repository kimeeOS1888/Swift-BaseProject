//
//  KMBaseViewController.swift
//  BsProject
//
//  Created by wujianming on 16/10/19.
//  Copyright © 2016年 szteyou. All rights reserved.
//  基类控制器

import UIKit

class KMBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseInit()
        KMLog.show("ENTER -> \(self.classForCoder)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        KMLog.show("EXIT -> \(self.classForCoder)")
    }

    // 属性初始化
    func baseInit() -> Void {
        self.title = "基类控制器"
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    // 自定义导航栏
    var km_navgationBar: KMNavigationBar? {
        didSet {
            
        }
    }
    
    // 隐藏导航左键，关闭事件
    func closeLeftItemActionAndHideItemImage(_ isHide: Bool) -> Void {
        self.km_navgationBar?.leftItem.isHidden = isHide
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
    }
}
