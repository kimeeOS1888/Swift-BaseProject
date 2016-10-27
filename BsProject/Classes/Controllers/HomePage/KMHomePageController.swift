//
//  KMHomePageController.swift
//  BsProject
//
//  Created by wujianming on 16/10/19.
//  Copyright © 2016年 szteyou. All rights reserved.
//

import UIKit

class KMHomePageController: KMBaseViewController {

    // 懒加载实现
    lazy var customLabel: KMCustomLabel = KMCustomLabel()
    
    // 懒加载的第二种实现
//    lazy var customLabel = {() -> KMCustomLabel in
//        let label = KMCustomLabel()
//        return label
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func commonInit() -> Void {
        self.title = "首页"
        
        view.addSubview(customLabel)
        customLabel.text = "自定义"
        customLabel.font = UIFont.systemFont(ofSize: 20)
        customLabel.sizeToFit()
        customLabel.center = view.center
        customLabel.layer.borderWidth = 1
    }
}
