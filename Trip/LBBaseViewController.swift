//
//  LBBaseViewController.swift
//  Trip
//
//  Created by Baogui Lu on 4/20/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import UIKit



class LBBaseViewController: UIViewController {
    
    func needUserLogin() -> Bool {
        return false;
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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


