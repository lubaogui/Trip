//
//  LBTabBarController.swift
//  Trip
//
//  Created by Baogui Lu on 4/12/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import UIKit

public struct LBTabBarItem {
    let name: String;
    let icon: String;
    let highlightIcon: String;
    let classType: UIViewController.Type;
}

class LBTabBarController: UITabBarController {
    
    let tabBarView = UIImageView();
    
    override var selectedIndex: Int {
        didSet {
            
        }
    }

    
    //TabController的子controller，当navRootVCs被设置时，LBTabController自动初始化tabBars
    private var tabBarItems: Array <LBTabBarItem>? {
        didSet {
            for (_, item) in tabBarItems!.enumerate() {
                let vc = item.classType
                let navVC = UINavigationController(rootViewController: vc.init());
                navVC.tabBarItem.title = item.name;
                self.addChildViewController(navVC);
                navVC.navigationBar.hidden = true;
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置tabBar的Items
        tabBarItems = [
            LBTabBarItem(name: "活动", icon: "H_unSelect", highlightIcon: "H", classType: LoginViewController.self),
            LBTabBarItem(name: "直播", icon: "U_unSelect", highlightIcon: "U", classType: LiveViewController.self),
            LBTabBarItem(name: "我", icon: "G_unSelect", highlightIcon: "G", classType: MeViewController.self)
        ];
        
        //初始化自定义界面
        initUI();
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

extension LBTabBarController {
    
    func initUI() {
        //隐藏自带的tabBar, 使用自定义的TabBarView
        self.tabBar.hidden = true;
        
        tabBarView.frame =
            CGRect(x: 0, y: self.view.screenFrame.height - 65, width: self.view.screenFrame.width, height: 65);
        tabBarView.backgroundColor = UIColor.clearColor();
        tabBarView.image = UIImage(named: "tab_bar_bg");
    
        tabBarView.userInteractionEnabled = true;
        self.view.addSubview(tabBarView);
        
        //默认第一个模块处于选择状态
        self.selectedIndex = 0;
        
        if tabBarItems != nil {
            for (index, tabBarItem) in (tabBarItems?.enumerate())! {
             
                let button = UIButton();
                button.tag = index + 100;
                button.frame = CGRect(x: 10 + index*80, y: 0, width: 80, height: 60);
                button.setTitle(tabBarItem.name, forState: UIControlState.Normal);
                button.titleLabel!.font = UIFont.systemFontOfSize(14);
                button.imageView?.contentMode = UIViewContentMode.Center;
                button.setImage(UIImage(named: tabBarItem.icon), forState: UIControlState.Normal);
                button.setImage(UIImage(named: tabBarItem.highlightIcon), forState: UIControlState.Selected);
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
                button.setTitleColor(UIColor(hexString: "0xffc800"), forState: UIControlState.Selected);
                
                let titleBounds = button.titleLabel!.bounds;
                let imgBounds = button.imageView!.bounds;
                
                var imgInsets = UIEdgeInsetsZero;
                var titleInsets = UIEdgeInsetsZero;
                
                imgInsets.bottom = button.frame.size.height / 2 - 20;
                imgInsets.right = -titleBounds.size.width;
                imgInsets.top = 10;
                
                titleInsets.top = button.frame.size.height / 2 + 15;
                titleInsets.left = -imgBounds.size.width;
                
                button.imageEdgeInsets = imgInsets;
                button.titleEdgeInsets = titleInsets;
                button.addTarget(self, action: #selector(LBTabBarController.buttonSelected(_:)), forControlEvents: UIControlEvents.TouchUpInside);
                tabBarView.addSubview(button);
                
                if index == self.selectedIndex {
                    button.selected = true;
                }
            }
        }
        
        let liveShootButton = UIButton(frame: CGRect(x: tabBarView.frameWidth - 65 - 20, y: 0, width: 65, height: 65));
        liveShootButton.setImage(UIImage(named: "icon_shoot"), forState: UIControlState.Normal);
        tabBarView.addSubview(liveShootButton);
    }
    
    //设置tabBar的子控制器
    func setTabBarItems(tabBarItems: Array<LBTabBarItem>) {
        self.tabBarItems = tabBarItems;
    }
    
}

//按钮点击事件扩展
extension LBTabBarController {
    
    func buttonSelected(sender:UIButton) {
        
        let originalTag = self.selectedIndex + 100;

        if (originalTag + 100 != sender.tag) {
            
            let preButton = self.tabBarView.viewWithTag(originalTag) as! UIButton;
            preButton.selected = false;
            sender.selected = true;
            self.selectedIndex = sender.tag - 100;
        }

    }
    
}
