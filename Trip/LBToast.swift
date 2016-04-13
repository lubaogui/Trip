//
//  LBToast.swift
//  Travel
//
//  Created by Baogui Lu on 10/23/15.
//  Copyright © 2015 Baogui Lu. All rights reserved.
//

import UIKit


enum ToastPosition {
    case Top, Center, Bottom;
}

class LBToast: NSObject {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let mainWindow = UIApplication.sharedApplication().keyWindow;
    var toastView = UIView();
    static var isShowing = false;
   
    func showToast(message:String?, duration: Double) {
        
        if (LBToast.isShowing == true) {
            return;
        }
        
        let messageString:String = message!;
        
        toastView = UIView(frame: CGRectMake(mainWindow!.frame.width/2 - 100, mainWindow!.frame.height/2 - 25, 200, 60));

        let messageLabel = UILabel(frame:CGRectMake(0, 0, 300, 30));
        messageLabel.textColor = UIColor.whiteColor();
        messageLabel.textAlignment = NSTextAlignment.Center;
        messageLabel.center = CGPoint(x: toastView.bounds.size.width/2, y: toastView.bounds.size.height/2);
        messageLabel.text = messageString;
        
        toastView.backgroundColor = UIColor(white: 0, alpha: 0.6);
        toastView.layer.masksToBounds = true;
        toastView.layer.cornerRadius = 4;
        toastView.addSubview(messageLabel);
        
        mainWindow!.addSubview(self.toastView);
        mainWindow!.bringSubviewToFront(self.toastView);
        LBToast.isShowing = true;
        
        NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: #selector(LBToast.dismiss), userInfo: nil, repeats: false);
    }
    
    func dismiss() {

        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.toastView.alpha = 0.0
            }) { (Bool) -> Void in
                self.toastView.removeFromSuperview();
                LBToast.isShowing = false;
        }
    }
    
}
