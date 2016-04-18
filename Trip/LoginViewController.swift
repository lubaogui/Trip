//
//  LoginViewController.swift
//  Trip
//
//  Created by Baogui Lu on 4/4/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //UI变量
    var mobileZone: String?;
    var mobileZoneDict: Dictionary<String, String>?;
    var mobile: String?;
    var password: String?;
    
    //UI元素
    let loginView: LoginView = LoginView();

    override func viewDidLoad() {
        super.viewDidLoad();
        
        let productCard = ProductCardView();
        print("begin set frame");
        productCard.frame = self.view.frame;
        
        //添加页面元素的响应函数
        loginView.frame = self.view.bounds;
        self.loginView.loginButton.addTarget(self, action: #selector(LoginViewController.actionLogin(_: )), forControlEvents: UIControlEvents.TouchUpInside);
        self.loginView.signupButton.addTarget(self, action: #selector(LoginViewController.actionSignup(_: )), forControlEvents: UIControlEvents.TouchUpInside);
        self.loginView.weiboLoginButton.addTarget(self, action: #selector(LoginViewController.actionWeiboLogin(_: )), forControlEvents: UIControlEvents.TouchUpInside);
        self.loginView.wechatLoginButton.addTarget(self, action: #selector(LoginViewController.actionWechatLogin(_: )), forControlEvents: UIControlEvents.TouchUpInside);
        self.loginView.closeButton.addTarget(self, action: #selector(LoginViewController.actionClose(_: )), forControlEvents: UIControlEvents.TouchUpInside);
        
        self.loginView.mobileInput.delegate = self;
        self.loginView.passwordInput.delegate = self;

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
        mobileZone = loginView.mobileZoneButton.titleLabel?.text;
        mobile = loginView.mobileInput.text;
        if mobile == nil {
            
        }
        password = loginView.passwordInput.text;
        if password == nil {
            
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
        print(self.isRootViewController());
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
