//
//  KMLeftViewController.swift
//  BsProject
//
//  Created by wujianming on 16/10/23.
//  Copyright © 2016年 szteyou. All rights reserved.
//

import UIKit

class KMLeftViewController: KMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func commonInit() -> Void {
        let leftImageView =  UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.6, height: UIScreen.main.bounds.size.height))
        leftImageView.image = UIImage(named: "leftImage")
        self.view.addSubview(leftImageView)
    }
}
