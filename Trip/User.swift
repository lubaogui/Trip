//
//  User.swift
//  Trip
//
//  Created by Baogui Lu on 4/11/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import Foundation


class User: NSObject, IdentityProtocol {
    
    var uid:Int = 0;
    var username:String;
    var avatar:String?;
    var mobile:String?;
    var sex:Int?;
    var contact:String?;
    
    override init() {
        uid = 0;
        username = "路伴儿";
        sex = 1;
        super.init();
    }
    
    init(dict:NSDictionary) {
        
        uid = dict["uid"] as! Int;
        username = dict["username"] as! String;
        sex = dict["sex"] as? Int;
        mobile = dict["mobile"] as? String;
        contact = dict["contact"]  as? String;
        
        super.init();
    }
    
    func findIdentity(id: Int) -> IdentityProtocol {
        //网络请求，获取用户信息
        return self;
    }
    
    func getId() -> Int {
        return self.uid;
    }
    
    func getAuthKey() -> String {
        return "HelloWorld";
    }
    
    func validateAuthKey(authKey: String) -> Bool {
        return true;
    }
    
}