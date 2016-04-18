//
//  DropdownMenu.swift
//  Trip
//
//  Created by Baogui Lu on 4/6/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import UIKit
import Foundation

struct MenuItem {
    let labelText: String;
    let value: String;
}

protocol DropdownMenuDelegate {
}

class DropdownMenu: UIControl {

    //UI元素
    let menuButton = UIButton();
    let iconDownImageView = UIImageView();
    var dropdownMenu:UITableView = UITableView();
    var originalFrame: CGRect?;
    
    //下拉列表框内容
    internal var items: Array<MenuItem>?;
    
    var selectedValue:String? {
        get {
            if selectedItem == nil {
                return defaultItem?.value;
            }
            else {
                return self.selectedItem?.value;
            }
        }
    }
    
    //default item
    var defaultItem: MenuItem? {
        didSet {
            menuButton.setTitle(defaultItem?.labelText, forState: UIControlState.Normal);
        }
    }
    
    //选中的菜单项
    var selectedItem: MenuItem? {
        didSet {
            menuButton.setTitle(selectedItem?.labelText, forState: UIControlState.Normal);
        }
    }
    
    //子菜单的选项
    var submenuOptions: Dictionary<String,String>?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //当菜单内容变化时，刷新UI
    private func updateUI() {
        self.dropdownMenu.reloadData();
        self.dropdownMenu.frame.size.height = self.dropdownMenu.contentSize.height;
        self.dropdownMenu.frame.origin = menuButton.getLowerLeftCornerPoint();
    }
    
    //menuButton点击事件处理
    func menuButtonClicked(sender:UIButton) {
        self.toggleMenu();
    }
    
    //菜单子项被选择的时候的
    func menuItemSelected(sender:UIButton) {
        self.selectedItem = self.items![sender.tag];
    }
    
    //切换选项列表的显示与否
    private func toggleMenu() {
        if self.dropdownMenu.hidden == true {
            self.dropdownMenu.hidden = false;
            frame.size.height = self.dropdownMenu.contentSize.height + self.menuButton.frame.size.height;
            self.updateUI();
        }
        else {
            self.dropdownMenu.hidden = true;
            frame.size.height = originalFrame!.size.height;
        }
    }
    
    //在加入父视图需要做的事情，主要是将所有的子空间元素产生并设置好属性，该动作只加载一次
    override func willMoveToSuperview(newSuperview: UIView?) {
        originalFrame = frame;
        
        //初始化的时候只将默认的Label和点击按钮显示
        menuButton.backgroundColor = UIColor.whiteColor();
        menuButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        menuButton.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        
        menuButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        menuButton.addTarget(self, action: #selector(DropdownMenu.menuButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        self.addSubview(menuButton);
        

        iconDownImageView.image = UIImage(named: "icon_down");
        self.menuButton.addSubview(iconDownImageView);
        
        self.dropdownMenu.hidden = true;
        self.dropdownMenu.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.dropdownMenu.delegate = self;
        self.dropdownMenu.dataSource = self;
        self.dropdownMenu.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        self.addSubview(self.dropdownMenu);
        
        self.clipsToBounds = false;
        
        
    }
    
    override func didMoveToSuperview() {
        self.updateUI();
    }
    
    //布局的重新绘制
    override func layoutSubviews() {
        menuButton.frame.size = originalFrame!.size;
        iconDownImageView.frame.origin = CGPoint(x: menuButton.frameWidth - 16 - 10, y: (self.menuButton.frameHeight - 5)/2);
        iconDownImageView.frame.size = CGSize(width: 16, height: 9);
      
        self.dropdownMenu.frame.origin = menuButton.getLowerLeftCornerPoint();
        self.dropdownMenu.frame.size.width = originalFrame!.width;
    }
    
    //重写hitTest，在dropdownMenu显示的时候可以响应相关的点击事件
    
}


/*
 tableview协议
 */
extension DropdownMenu: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath);
        cell.textLabel?.text = self.items![indexPath.row].labelText;
        cell.backgroundColor = UIColor.whiteColor();
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        self.selectedItem = self.items![indexPath.row];
        self.toggleMenu();
    }
    
}
