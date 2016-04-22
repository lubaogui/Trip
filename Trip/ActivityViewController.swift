//
//  ActivityViewController.swift nav的根控制器
//  Trip
//
//  Created by Baogui Lu on 4/11/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import UIKit

class ActivityViewController: LBBaseViewController {
    
    
    
    let tableView = UITableView();


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "抱抱";
        
        tableView.frame = self.view.frame;
        tableView.backgroundColor  = UIColor.orangeColor();
        self.view.addSubview(tableView);


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //tableViewUI初始化
    func setupTableView() {
        
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


extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
        return UIView() as! UITableViewCell;
    }
    
    
    
    
    
}


//productCardView delegate
extension ActivityViewController: ProductCardViewDelegate {
    
    func productImageClicked(productId: Int) {
        
    }
    
    func avatarButtonClicked(uid: Int) {
        
    }
    
    func likeButtonClicked(uid: Int, productId: Int) {
        
    }
    
    func bookingButtonClicked(productId: Int, uid: Int) {
        
    }
    

    
}
