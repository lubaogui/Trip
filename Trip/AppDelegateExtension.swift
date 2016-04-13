//
//  AppDelegateExtension.swift
//  Trip
//
//  Created by Baogui Lu on 4/11/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {

    //获取tabBarVC
    func getTabBarVC() -> UITabBarController {
        if self.tabBarVC == nil {
            self.tabBarVC = LBTabBarController();
        }
        return self.tabBarVC!;
    }
}