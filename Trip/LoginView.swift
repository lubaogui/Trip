//
//  LoginView.swift
//  Trip
//
//  Created by Baogui Lu on 4/4/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import UIKit

class LoginView: UIControl {
    
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
    let mobileZoneButton = UIButton();
    let countryDropdownList = UITableView();
    let mobileInput = UITextField();
    let passwordInput = UITextField();
    
    let loginButton = UIButton(type: UIButtonType.RoundedRect);
    let forgetPasswordButton = UIButton();
    let signupButton = UIButton();
    
    let weiboLoginButton = UIButton();
    let wechatLoginButton = UIButton();
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        //背景图像
        backgroundImageView.image = UIImage(named: "login_bg");
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill;
        self.addSubview(backgroundImageView);
        backgroundImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0));
        }

        
        //关闭按钮
        closeButton.backgroundColor = UIColor.clearColor();
        closeButton.setTitle("关闭", forState: UIControlState.Normal);
        closeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        self.addSubview(closeButton);
        closeButton.snp_makeConstraints { (make) in
            make.height.equalTo(50);
            make.width.equalTo(50);
            make.topMargin.equalTo(10);
            make.rightMargin.equalTo(-10);
        }
        
        //Logo图片
        topLogoImageView.image = UIImage(named: "logo_face");
        self.addSubview(topLogoImageView);
        topLogoImageView.snp_makeConstraints { (make) in
            make.top.equalTo(60);
            make.width.equalTo(100).priorityHigh();
            make.height.equalTo(100).priorityHigh();
            make.centerX.equalTo(self);
        }
        
        //手机号登录Label
        mobileLoginLabel.text = "手机号登陆";
        mobileLoginLabel.textAlignment = NSTextAlignment.Center;
        mobileLoginLabel.textColor = UIColor.blackColor();
        self.addSubview(mobileLoginLabel);
        mobileLoginLabel.snp_makeConstraints { (make) in
            make.height.equalTo(30);
            make.width.equalTo(150);
            make.centerX.equalTo(topLogoImageView);
            make.top.equalTo(topLogoImageView.snp_bottom).offset(20);
        }
        
        let defaultMenuItem = MenuItem(labelText: "中国+86", value: "+86");
        
        var mobileZoneList = [
            MenuItem(labelText: "美国+11", value: "+11"),
            MenuItem(labelText: "日本+12", value: "+12"),
        ];
        
        mobileZoneList.append(defaultMenuItem);
        

        //区号选择button
        mobileZoneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        mobileZoneButton.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        mobileZoneButton.backgroundColor = UIColor.whiteColor();
        mobileZoneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        mobileZoneButton.setTitle(defaultMenuItem.labelText, forState: UIControlState.Normal);
        mobileZoneButton.layer.cornerRadius = 5;
        mobileZoneButton.layer.masksToBounds = true;
        self.addSubview(mobileZoneButton);
        mobileZoneButton.snp_makeConstraints { (make) in
            make.leftMargin.equalTo(15);
            make.height.equalTo(40);
            make.width.equalTo(100);
            make.top.equalTo(mobileLoginLabel.snp_bottom).offset(20);
        }
        
        //手机号输入框
        mobileInput.borderStyle = UITextBorderStyle.RoundedRect;
        mobileInput.keyboardType = UIKeyboardType.NumberPad;
        self.addSubview(mobileInput);
        mobileInput.snp_makeConstraints { (make) in
            make.height.equalTo(40);
            make.right.equalTo(self).offset(-15);
            make.left.equalTo(mobileZoneButton.snp_right).offset(15);
            make.centerY.equalTo(mobileZoneButton).offset(0);
        }
        
        //密码输入框
        passwordInput.secureTextEntry = true;
        passwordInput.borderStyle = UITextBorderStyle.RoundedRect;
        self.addSubview(passwordInput);
        passwordInput.snp_makeConstraints { (make) in
            make.height.equalTo(40);
            make.centerX.equalTo(topLogoImageView);
            make.left.equalTo(mobileZoneButton.snp_left);
            make.right.equalTo(mobileInput);
            make.top.equalTo(mobileInput.snp_bottom).offset(20);
        }
    
        //登录按钮
        loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        loginButton.setTitle("登陆", forState: UIControlState.Normal);
        loginButton.backgroundColor = UIColor(hex: 0xffc800);
        loginButton.layer.cornerRadius = 10;
        self.addSubview(loginButton);
        loginButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self);
            make.height.equalTo(40);
            make.right.equalTo(-50);
            make.left.equalTo(50);
            make.top.equalTo(passwordInput.snp_bottom).offset(20);
        }

        //忘记密码按钮
        forgetPasswordButton.setTitle("忘记密码", forState: UIControlState.Normal);
        forgetPasswordButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        self.addSubview(forgetPasswordButton);
        forgetPasswordButton.snp_makeConstraints { (make) in
            make.width.equalTo(100);
            make.height.equalTo(50);
            make.topMargin.equalTo(loginButton.snp_bottom).offset(10);
            make.left.equalTo(self).offset(20);
        }
        
        //注册按钮
        signupButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        signupButton.setTitle("注册", forState: UIControlState.Normal);
        self.addSubview(signupButton);
        signupButton.snp_makeConstraints { (make) in
            make.width.equalTo(100);
            make.height.equalTo(50);
            make.topMargin.equalTo(loginButton.snp_bottom).offset(10);
            make.right.equalTo(self).offset(-20);
        }
        
        //微博登录按钮
        weiboLoginButton.setImage(UIImage(named: "login_weibo"), forState: UIControlState.Normal);
        self.addSubview(weiboLoginButton);
        weiboLoginButton.snp_makeConstraints { (make) in
            make.height.equalTo(61);
            make.width.equalTo(61);
            make.left.equalTo(self).offset(50);
            make.top.equalTo(forgetPasswordButton.snp_bottom).offset(15);
        }
      
        //微信登录按钮
        wechatLoginButton.setImage(UIImage(named: "login_wechat"), forState: UIControlState.Normal);
        wechatLoginButton.frame.size = CGSize(width: 100, height: 50);
        self.addSubview(wechatLoginButton);
        wechatLoginButton.snp_makeConstraints { (make) in
            make.height.equalTo(61);
            make.width.equalTo(61);
            make.right.equalTo(self).offset(-50);
            make.centerY.equalTo(weiboLoginButton);
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}



