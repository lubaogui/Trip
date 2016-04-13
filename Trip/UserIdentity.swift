//
//  UserIdentity.swift 本地用户信息
//  Travel
//
//  Created by Baogui Lu on 9/18/15.
//  Copyright © 2015 Baogui Lu. All rights reserved.
//

import Foundation

protocol IdentityProtocol {
    func findIdentity(id:Int) -> IdentityProtocol;
    func getId() -> Int;
    func getAuthKey() -> String;
    func validateAuthKey(authKey:String) -> Bool;
}

enum UserIdentityEvent:String {
    case BeforeLogin = "beforeLogin";
    case AfterLogin = "afterLogin";
    case BeforeLogout = "beforeLogout";
    case AfterLogout = "afterLogout";
}


class UserIdentity:NSObject {
    
    var identityClass:String?;  //实际的数据模型类
    var _identity:IdentityProtocol?;
    var enableAutoLogin:Bool = false;
    var enableSession:Bool = true;
    var authTimeout = 0;
    var absoluteAuthTimeout = 0;
    var autoRenewCookie = true;
    var identityCookie:[String:String]?;
    
    var uid: Int?;
    
    override init() {
        super.init();
        identityClass = "User";
        
        if self.identityClass == nil {
            //异常处理
            print("用户属性类为空，异常!");
        }
    }
    
    
    func getIdentity(autoRenew:Bool = true)->IdentityProtocol? {
        return _identity as IdentityProtocol?;
    }
    
    func setIdentity(identity:IdentityProtocol) {
        self._identity = identity;
    }
    
    func switchIdentity(identity:IdentityProtocol?, duration:Int = 0) {
        self.setIdentity(identity!);
    }
    
    /**
    用户登录
    
    :param: identity 用户登陆之后，用于设置本地状态
    :param: duration 登录状态保持时间
    */
    func login(identity:IdentityProtocol, duration:Int = 0) -> Bool {
        if beforeLogin(identity, cookieBased: false, duration: duration) {
            self.switchIdentity(identity, duration: duration);
            uid = identity.getId();
            self.afterLogin(identity, cookieBased: false, duration: duration)
        }
        
        return !self.isGuest();
    }
    
    
    func logout(destroySession:Bool) -> Bool {
        
        let identity = self._identity;
        
        if (identity != nil && self.beforeLogout(identity!)) {
            self.switchIdentity(nil);
        }
        self.afterLogout(identity!);
        return self.isGuest();
    }
    
    
    /**
    判断用户是否登录
    
    :returns: Bool 用户是否登录
    */
    func isGuest() -> Bool {
        if self._identity == nil  {
            return true;
        }
        else {
            return false;
        }
    }
    
    //登陆之前的发送事件
    func beforeLogin(identity:IdentityProtocol, cookieBased:Bool, duration:Int) -> Bool {
        let notification:NSNotification = NSNotification(name: UserIdentityEvent.BeforeLogin.rawValue, object: nil, userInfo: nil);
        NSNotificationCenter.defaultCenter().postNotification(notification);
        return true;
    }
    
    //登陆之后的事件发送
    func afterLogin(identity:IdentityProtocol, cookieBased:Bool, duration:Int) -> Bool {
        let notification:NSNotification = NSNotification(name: UserIdentityEvent.AfterLogin.rawValue, object: nil, userInfo: nil);
        NSNotificationCenter.defaultCenter().postNotification(notification);
        return true;
    }
    
    /**
    登出之前事件发送
    :param: identity 用户标示
    :returns: Bool 是否成功
    */
    func beforeLogout(identity:IdentityProtocol) -> Bool {
        let notification:NSNotification = NSNotification(name: UserIdentityEvent.BeforeLogout.rawValue, object: nil, userInfo: nil);
        NSNotificationCenter.defaultCenter().postNotification(notification);
        return true;
    }
    
    /**
    登出之后的事件发送
    :param: identity 用户标示
    :returns: Bool 是否成功
    */
    func afterLogout(identity:IdentityProtocol) -> Bool {
        let notification:NSNotification = NSNotification(name: UserIdentityEvent.AfterLogout.rawValue, object: nil, userInfo: nil);
        NSNotificationCenter.defaultCenter().postNotification(notification);
        return true;
    }
    
}
