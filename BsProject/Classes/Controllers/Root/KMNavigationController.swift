//
//  KMNavigationController.swift
//  BsProject
//
//  Created by wujianming on 16/10/19.
//  Copyright © 2016年 szteyou. All rights reserved.
//

import UIKit

class KMNavigationController: KMBaseNavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullScreenGesture(full: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        let customBar = KMNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64.0))
        let baseVc = rootViewController as! KMBaseViewController
        baseVc.km_navgationBar = customBar
        baseVc.view.addSubview(customBar)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            let customBar = KMNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64.0))
            customBar.leftItem.setImage(UIImage.init(named: "back-WHITH"), for: .normal)
            let baseVc = viewController as! KMBaseViewController
            baseVc.km_navgationBar = customBar
            baseVc.view.addSubview(customBar)
            
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func fullScreenGesture(full: Bool) -> Void {
        if full {
            //获取系统侧滑手势
            let systemPopGes = self.interactivePopGestureRecognizer
            //禁用系统侧滑
            systemPopGes?.isEnabled = false
            //获取系统实现侧滑的action
            let systemAction = NSSelectorFromString("handleNavigationTransition:")
            //自定义滑动手势
            let myPan = UIPanGestureRecognizer(target: systemPopGes!.delegate, action: systemAction)
            myPan.maximumNumberOfTouches = 1
            myPan.delegate = self
            //向系统实现侧滑的view中加入自定义的滑动手势
            systemPopGes?.view?.addGestureRecognizer(myPan)
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.childViewControllers.count == 1 {
            // 表示用户在根控制器界面，就不需要触发滑动手势，
            return false
        }
        
        // 自定义页面不响应手势
//        let vc = self.childViewControllers.last! as UIViewController
//        if vc.classForCoder == KMBaseViewController.classForCoder() {
//
//            return false
//        }
        
        return true
    }
}
