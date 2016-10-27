//
//  KMViewControllerExtension .swift
//
//  Created by wujianming on 15/12/15.
//  Copyright © 2016年 Kimee. All rights reserved.
//

import UIKit

internal enum  SHViewControllerExtensionEventNotificationName: String {
    case Pan = "ViewControllerMainFramePanGestureRecognizer"
    case Tap = "ViewControllerMainFrameTapGestureRecognizer"
}

public extension UIViewController {
    
    //MARK: - 添加处理滑动手势
    
    /**
    添加拖拽手势响应，给需要处理响应的UIViewController调用
    */
    public func addMainFramePanGestureRecognizer()
    {
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(self.mainFramePanGestureRecognizer(sender:)))
        self.view.addGestureRecognizer(pan);
    }
    
    /**
     处理拖拽手势
     */
    internal func mainFramePanGestureRecognizer(sender: UIPanGestureRecognizer)
    {
        var dic = Dictionary<String,AnyObject>();
        dic["panGestureRecognizer"] = sender
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SHViewControllerExtensionEventNotificationName.Pan.rawValue), object: self, userInfo: dic)
    }
    
    //MARK: - 添加处理点击手势
    
    /**
    表示事件屏蔽tapView的唯一Tag
    */
    internal static var tapViewTag:NSInteger {
        return 15000
    }
    
    /**
     添加点击手势
     */
    public func addOnceMainFrameTapGestureRecognizer()
    {
        let view = UIView(frame: self.view.bounds)
        view.tag = UIViewController.tapViewTag;
        //添加点击事件
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.mainFrameTapGestureRecognizer(sender:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap);
        //代理拖动事件
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(self.onceViewPanGestureRecognizer(sender:)))
        self.view.addGestureRecognizer(pan);
        
        self.view.addSubview(view)
    }
    
    public func removeOnceMainFrameTapGestureRecognizer() -> Void {
        self.view.viewWithTag(UIViewController.tapViewTag)?.removeFromSuperview()
    }
    
    /**
     处理点击手势
     */
    internal func mainFrameTapGestureRecognizer(sender: UITapGestureRecognizer)
    {
        var dic = Dictionary<String,AnyObject>();
        dic["tapGestureRecognizer"] = sender
        NotificationCenter.default.post(name: NSNotification.Name(SHViewControllerExtensionEventNotificationName.Tap.rawValue), object:self, userInfo:dic)
        self.view.viewWithTag(UIViewController.tapViewTag)?.removeFromSuperview()
    }
    
    /**
     处理代理的拖拽手势
     */
    internal func onceViewPanGestureRecognizer(sender: UIPanGestureRecognizer)
    {
        if (sender.state == UIGestureRecognizerState.ended)
        {
            self.view.viewWithTag(UIViewController.tapViewTag)?.removeFromSuperview()
        }
        var dic = Dictionary<String,AnyObject>();
        dic["panGestureRecognizer"] = sender
        NotificationCenter.default.post(name: NSNotification.Name(SHViewControllerExtensionEventNotificationName.Pan.rawValue), object:self, userInfo:dic)
    }
}
