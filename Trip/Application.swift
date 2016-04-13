//
//  Application.swift
//  Travel
//
//  Created by Baogui Lu on 9/19/15.
//  Copyright © 2015 Baogui Lu. All rights reserved.
//

import Foundation

class Application {
    
    static let sharedInstance = Application();
    lazy var user = UserIdentity();
    lazy var webRequest = BaseHttpRequest();
    lazy var toast = LBToast();
    
    /*
    private init() {
    // Private initialization to ensure just one instance is created.
    }
    */
    
    func getHomeController() -> NSString {
        
        return "IndexViewController";
    }
    
    func setHomeController(controller: NSString) {
        
    }
    
    func coreComponents() -> NSDictionary {
        return [
            "user":"UserIdentity",
        ];
    }
    
}