//
//  LoginView.swift
//  Trip
//
//  Created by Baogui Lu on 4/4/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    //手机号
    var mobile: String? {
        get {
            return self.mobileInput.text;
        }
        set {
            self.mobileInput.text = newValue;
        }
    }
    //变量
    var password: String? {
        get {
            return self.passwordInput.text;
        }
    }
    
    //UI元素
    let closeButton = UIButton();
    let backgroundImageView = UIImageView();
    let topLogoImageView = UIImageView();
    let mobileLoginLabel = UILabel();
    let mobileZoneDropdownMenu = DropdownMenu();
    let mobileInput = UITextField();
    let passwordInput = UITextField();
    
    let loginButton = UIButton();
    let forgetPasswordButton = UIButton();
    let signupButton = UIButton();
    
    let weiboLoginButton = UIButton();
    let wechatLoginButton = UIButton();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        self.backgroundColor = UIColor.grayColor();
        
        closeButton.frame.size = CGSize(width: 50, height: 50);
        closeButton.frame.origin = CGPoint(x: self.screenFrame.width - 60, y: 20)
        closeButton.backgroundColor = UIColor.clearColor();
        closeButton.setTitle("关闭", forState: UIControlState.Normal);
        closeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        self.addSubview(closeButton);
        
        topLogoImageView.frame.size = CGSize(width: 100, height: 100);
        topLogoImageView.center = self.center;
        topLogoImageView.center.y = 120;
        topLogoImageView.image = UIImage(named: "logo_face");
        self.addSubview(topLogoImageView);
        
        mobileLoginLabel.text = "手机号登陆";
        mobileLoginLabel.textAlignment = NSTextAlignment.Center;
        mobileLoginLabel.textColor = UIColor.blackColor();
        mobileLoginLabel.frame.size = CGSize(width: 150, height: 40);
        mobileLoginLabel.center = self.center;
        mobileLoginLabel.center.y = 220;
        self.addSubview(mobileLoginLabel);
        
        let mobileZoneList = [
            MenuItem(labelText: "中国+86", value: "+86"),
            MenuItem(labelText: "美国+11", value: "+11"),
            MenuItem(labelText: "日本+12", value: "+12"),
            ];
        
        mobileZoneDropdownMenu.frame = CGRect(x: 15, y: 260, width: 120, height: 40);
        mobileZoneDropdownMenu.defaultItem = MenuItem(labelText: "中国+86", value: "+86");
        mobileZoneDropdownMenu.items = mobileZoneList;
        mobileZoneDropdownMenu.layer.cornerRadius = 2;
        mobileZoneDropdownMenu.layer.masksToBounds = true;
        
        mobileInput.frame.size = CGSize(width: 200, height: 40);
        mobileInput.frame.origin = CGPoint(x: 150, y: 260);
        mobileInput.borderStyle = UITextBorderStyle.RoundedRect;
        mobileInput.keyboardType = UIKeyboardType.NumberPad;
        
        self.addSubview(mobileInput);
        
        passwordInput.frame.size = CGSize(width: 300, height: 40);
        passwordInput.frame.origin = CGPoint(x: 15, y: 320);
        passwordInput.secureTextEntry = true;
        passwordInput.borderStyle = UITextBorderStyle.RoundedRect;
        self.addSubview(passwordInput);
        
        loginButton.frame.size = CGSize(width: 200, height: 50);
        loginButton.frame.origin = CGPoint(x: 40, y: 380);
        loginButton.center.x = self.center.x;
        loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        loginButton.setTitle("登陆", forState: UIControlState.Normal);
        loginButton.backgroundColor = UIColor.whiteColor();
        self.addSubview(loginButton);
        
        forgetPasswordButton.frame.size = CGSize(width: 100, height: 50);
        forgetPasswordButton.frame.origin = CGPoint(x: 40, y: 440);
        forgetPasswordButton.setTitle("忘记密码", forState: UIControlState.Normal);
        forgetPasswordButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        self.addSubview(forgetPasswordButton);
        
        signupButton.frame.size = CGSize(width: 100, height: 50);
        signupButton.frame.origin = CGPoint(x: self.screenFrame.width - signupButton.frame.width - 30, y: 440);
        signupButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        signupButton.setTitle("注册", forState: UIControlState.Normal);
        self.addSubview(signupButton);
        
        weiboLoginButton.frame.size = CGSize(width: 100, height: 50);
        weiboLoginButton.frame.origin = CGPoint(x: 30, y: self.frameHeight - 150);
        
        weiboLoginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        weiboLoginButton.setTitle("微博登陆", forState: UIControlState.Normal);
        self.addSubview(weiboLoginButton);
        
        wechatLoginButton.frame.size = CGSize(width: 100, height: 50);
        wechatLoginButton.frame.origin = CGPoint(x: self.screenFrame.width - weiboLoginButton.frame.width - 30, y: self.frameHeight - 150);
        wechatLoginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        wechatLoginButton.setTitle("微信登陆", forState: UIControlState.Normal);
        self.addSubview(wechatLoginButton);
        
        //以为含有弹出层，必须具有高优先级
        self.addSubview(mobileZoneDropdownMenu);
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}


