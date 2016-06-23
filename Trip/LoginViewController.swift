//
//  LoginViewController.swift
//  Trip
//
//  Created by Baogui Lu on 4/4/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import UIKit
import Alamofire;

class LoginViewController: LBBaseViewController {
    
    //UI变量
    var mobileZone: String?;
    var mobileZoneDict: Dictionary<String, String>?;
    var mobile: String?;
    var password: String?;
    
    //UI元素
    let loginView: LoginView = LoginView();

    override func viewDidLoad() {
        super.viewDidLoad();
        
        //添加页面元素的响应函数
        loginView.frame = self.view.bounds;
        self.loginView.loginButton.addTarget(self, action: #selector(LoginViewController.actionLogin(_: )), forControlEvents: UIControlEvents.TouchUpInside);
        self.loginView.signupButton.addTarget(self, action: #selector(LoginViewController.actionSignup(_: )), forControlEvents: UIControlEvents.TouchUpInside);
        self.loginView.weiboLoginButton.addTarget(self, action: #selector(LoginViewController.actionWeiboLogin(_: )), forControlEvents: UIControlEvents.TouchUpInside);
        self.loginView.wechatLoginButton.addTarget(self, action: #selector(LoginViewController.actionWechatLogin(_: )), forControlEvents: UIControlEvents.TouchUpInside);
        self.loginView.closeButton.addTarget(self, action: #selector(LoginViewController.actionClose(_: )), forControlEvents: UIControlEvents.TouchUpInside);
        
        self.loginView.mobileInput.delegate = self;
        self.loginView.passwordInput.delegate = self;
        loginView.backgroundColor = UIColor.whiteColor();

        self.view.addSubview(self.loginView);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//UI元素的相应事件
extension LoginViewController {
    
    func actionLogin(sender:UIButton) {
        
        print("login button pressed!");

        mobileZone = loginView.mobileZoneButton.titleLabel?.text;
        mobile = loginView.mobileInput.text;
        if mobile == nil {
            //提示用户手机号输入不能为空
            mobile = "18301579720";
        }
        password = loginView.passwordInput.text;
        if password == nil {
            //提示用户密码不能为空
            password = "1234567890";
        }
        
        
        let params = [
            "mobile_zone" : (mobileZone as! AnyObject),
            "mobile" : (mobile as! AnyObject),
            "password" : (password  as! AnyObject)
        ];
        
        func processData(data:AnyObject?) -> Void {
            print("处理用户定义函数");
            print("用户登录成功");
            print(data);
        }
        
        func failureData(error:NSError?) -> Void {
            print(error);
        }
        
        Application.sharedInstance.webRequest.post("http://travel.lubanr.com/passport/ajax-login", parameters: params, encoding: .URL, successHandler: processData, failureHandler: failureData);
        
        //发送登录成功消息
        NSNotificationCenter.defaultCenter().postNotificationName("LoginSucceededNotifycation", object: nil);
        
        if self.isRootViewController() == false {
            
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        
    }
    
    func actionSignup(sender:UIButton) {
        //跳转到注册页面
        print("signup button clicked");
        let signupVC = SignupViewController();
        self.navigationController?.pushViewController(signupVC, animated: true);
    }
    
    func actionWeiboLogin(sender:UIButton) {
        
        print("weiboLoginButton clicked");
    }
    
    func actionWechatLogin(sender:UIButton) {
        print("wechatLoginButton clicked");
    }
    
    func actionClose(sender:UIButton) {
        if self.isRootViewController() == false {
            self.dismissViewControllerAnimated(true, completion: nil);
        }
    }
    
}


//UI元素的代理方法
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        print("should return");
        return true;
    }
}
