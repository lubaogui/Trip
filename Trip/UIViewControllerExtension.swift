//
//  UIViewControllerExtension.swift
//  Trip
//
//  Created by Baogui Lu on 4/11/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //获取当前window的根控制器
    func getRootViewController() -> UIViewController? {
        return UIApplication.sharedApplication().keyWindow?.rootViewController;
    }
    
    //判断当前控制器是否为根控制器
    func isRootViewController() -> Bool {
        if self == self.getRootViewController() {
            return true;
        }
        else {
            return false;
        }
    }
    
    //获取应用代理
    var appDelegate: AppDelegate? {
        get {
            return UIApplication.sharedApplication().delegate as? AppDelegate;
        }
    }
    
    //获取referrence控制器
    var referrenceVC: UIViewController? {
        return appDelegate?.referrenceVC;
    }
    
    //设置referrence控制器
    func setReferrenceVC(viewController: UIViewController) -> Void {
        appDelegate?.referrenceVC = viewController;
    }
    
    //获取本次操作的目标VC(页面)
    var targetVC: UIViewController? {
        return appDelegate?.targetVC;
    }
    
    //设置目标targetVC
    func setTargetVC(viewController: UIViewController) {
        appDelegate?.targetVC = viewController;
    }
    
    //需要登录的controller在此判断
    func needLogin() -> Bool {
        return true;
    }
    
}