//
//  KMMainframeViewController.swift
//
//  Created by wujianming on 15/12/15.
//  Copyright © 2016年 Kimee. All rights reserved.
//

import UIKit


class KMMainframeViewController: KMBaseViewController {
    
    /**
     左边视图控制器最大占据屏幕总宽度的比例
     */
    public var leftViewControllerMaxScaleOfWidth:CGFloat = 0.8 {
        didSet {
            self.leftViewControllerMaxScaleOfWidth = max(0.1, self.leftViewControllerMaxScaleOfWidth)
            self.leftViewControllerMaxScaleOfWidth = min(1.0, self.leftViewControllerMaxScaleOfWidth)
        }
    }
    
    /**
     左边视图控制器刚开始展示的区域起始值占自身总宽度的比例
     */
    public var leftViewControllerStartScaleOfWidth:CGFloat = 0.2 {
        didSet {
            self.leftViewControllerStartScaleOfWidth = max(0.0, self.leftViewControllerStartScaleOfWidth)
            self.leftViewControllerStartScaleOfWidth = min(1.0, self.leftViewControllerStartScaleOfWidth)
        }
    }
    
    var rightViewControllerPanLocationX: CGFloat = 0.2
    
    /**
     右边视图控制器移动到最右边时的缩放比例
     */
    public var rigthViewControllerMinScaleSize:(sx:CGFloat,sy:CGFloat) = (1.0,1.0) {
        didSet {
            self.rigthViewControllerMinScaleSize.sx = max(0.1, self.rigthViewControllerMinScaleSize.sx)
            self.rigthViewControllerMinScaleSize.sx = min(1.0, self.rigthViewControllerMinScaleSize.sx)
            self.rigthViewControllerMinScaleSize.sy = max(0.1, self.rigthViewControllerMinScaleSize.sy)
            self.rigthViewControllerMinScaleSize.sy = min(1.0, self.rigthViewControllerMinScaleSize.sy)
            self.leftViewController?.view.frame = CGRect(x: self.leftViewControllerMoveRangeX.min, y: 0, width: self.view.bounds.width * (2.0 - self.leftViewControllerStartScaleOfWidth), height: self.view.bounds.height)
        }
    }
    
    /**
     左边视图控制器view的X移动的最小和最大值
     */
    public var leftViewControllerMoveRangeX:(min:CGFloat,max:CGFloat) {
        get {
            let minMoveX = -self.view.frame.width * self.leftViewControllerStartScaleOfWidth
            return (min:minMoveX,max:0.0)
        }
    }
    /**
     右边视图控制器view的X移动的最小和最大值
     */
    public var rigthViewControllerMoveRangeX:(min:CGFloat,max:CGFloat) {
        get {
            let maxMoveX = self.view.frame.width * self.leftViewControllerMaxScaleOfWidth
            return (0.0,maxMoveX)
        }
    }
    
    
    /**
     右边视图控制器
     */
    public var rightViewController:UIViewController? = nil {
        didSet {
            oldValue?.removeFromParentViewController();
            oldValue?.view.removeFromSuperview();
            if (self.rightViewController != nil) {
                self.view.addSubview(self.rightViewController!.view);
                self.addChildViewController(self.rightViewController!);
                //添加拖拽手势
                self.addMainFramePanGestureRecognizer()
            }
        }
    }
    
    /**
     左边视图控制器
     */
    public var leftViewController:UIViewController? = nil {
        didSet {
            oldValue?.removeFromParentViewController();
            oldValue?.view.removeFromSuperview();
            if (self.leftViewController != nil) {
                self.view.addSubview(self.leftViewController!.view);
                self.addChildViewController(self.leftViewController!);
            }
        }
    }
    
    /**
     添加通知消息监控
     */
    internal func addNotificationMoniter() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.rigthViewControllerPanGestureRecognizer(notification:)), name: NSNotification.Name.init(SHViewControllerExtensionEventNotificationName.Pan.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.rigthViewControllerTapGestureRecognizer(notification:)), name: NSNotification.Name(rawValue: SHViewControllerExtensionEventNotificationName.Tap.rawValue), object: nil)
    }
    
    //MARK: - 事件响应
    
    internal var lastMoveX:CGFloat = 0.0
    
    /**
     处理拖拽消息
     */
    internal func rigthViewControllerPanGestureRecognizer(notification:NSNotification) {
        let panGestureRecognizer = notification.userInfo!["panGestureRecognizer"] as! UIPanGestureRecognizer;
        let rigthVcRangeX = self.rigthViewControllerMoveRangeX
        let currenX = self.rightViewController!.view.frame.origin.x

        let rightLocate = panGestureRecognizer.location(in: self.rightViewController?.view)
        let rightVc = self.rightViewController as! KMTabBarController
        if rightLocate.x > UIScreen.main.bounds.size.width * self.rightViewControllerPanLocationX || (rightVc.selectedViewController?.childViewControllers.count)! > 1 {
            self.openLeftView(open: false, animation: true)
            return
        }
        
        let translation = panGestureRecognizer.translation(in: self.view);
        if (panGestureRecognizer.state == UIGestureRecognizerState.began) {
            lastMoveX = 0.0;
        }
        else if(panGestureRecognizer.state == UIGestureRecognizerState.changed) {
            // 解决从右向左滑，会自动打开侧滑栏的问题
            if self.rightViewController?.view.frame.origin.x == 0 && translation.x <= 0 {
                return
            }
            
            let moveOffset = translation.x - lastMoveX
            lastMoveX = translation.x
            var moveX = currenX + moveOffset
            moveX = max(moveX, rigthVcRangeX.min)
            moveX = min(moveX, rigthVcRangeX.max)
            let scaleX = 1.0 - moveX / rigthVcRangeX.max * (1.0 - self.rigthViewControllerMinScaleSize.sx);
            let scaleY = 1.0 - moveX / rigthVcRangeX.max * (1.0 - self.rigthViewControllerMinScaleSize.sy);
            
            self.rightViewController?.view.transform = CGAffineTransform(scaleX: scaleX,y: scaleY)
            self.rightViewController?.view.frame.origin.x = moveX;
            self.leftViewController?.view.frame.origin.x = leftViewControllerMoveRangeX.min + moveX * self.leftViewControllerStartScaleOfWidth / self.leftViewControllerMaxScaleOfWidth
        }
        else if (panGestureRecognizer.state == UIGestureRecognizerState.ended) {
            self.openLeftView(open: currenX >= rigthVcRangeX.max * 0.5, animation: true)
        }
    }
    
    /**
     处理点击事件
     */
    internal func rigthViewControllerTapGestureRecognizer(notification:NSNotification) {
        self.openLeftView(open: false, animation: true)
    }
    
    /**
     回到最初或最终位置
     */
    public func openLeftView(open:Bool, animation:Bool)
    {
        let duration = animation ? 0.15 :0.0
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            if open {
                self.rightViewController?.view.transform = CGAffineTransform(scaleX: self.rigthViewControllerMinScaleSize.sx, y: self.rigthViewControllerMinScaleSize.sy)
                self.rightViewController?.view.frame.origin.x = self.rigthViewControllerMoveRangeX.max
                self.leftViewController?.view.frame.origin.x = self.leftViewControllerMoveRangeX.max
                //添加点击事件，这里需要view屏蔽rightview本身的其他事件
                self.rightViewController?.addOnceMainFrameTapGestureRecognizer()
            }
            else {
                self.rightViewController?.view.transform = .identity
                self.rightViewController?.view.frame.origin.x = self.rigthViewControllerMoveRangeX.min
                self.leftViewController?.view.frame.origin.x = self.leftViewControllerMoveRangeX.min
                self.rightViewController?.removeOnceMainFrameTapGestureRecognizer()
            }
        })
    }
}

extension KMMainframeViewController {
    
    //MARK: - 方法覆盖
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.addNotificationMoniter()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //初始化位置大小
        self.leftViewController?.view.frame = CGRect(x: self.leftViewControllerMoveRangeX.min, y: 0, width: self.view.bounds.width * (2.0 - self.leftViewControllerStartScaleOfWidth), height: self.view.bounds.height)
        self.rightViewController?.view.frame = self.view.bounds
    }
}

