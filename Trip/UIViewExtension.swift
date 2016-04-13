//
//  UIViewExtension.swift
//  Trip
//
//  Created by Baogui Lu on 4/4/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var screenFrame: CGRect {
        get {
            return UIScreen.mainScreen().bounds;
        }
    }
    
    var frameHeight: CGFloat {
        get {
            return self.frame.height;
        }
    }
    
    var frameWidth: CGFloat {
        get {
            return self.frame.width;
        }
    }

    func getLowerLeftCornerPoint() -> CGPoint {
        return CGPoint(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height);
    }
    
    func getRightX() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width;
    }
    
}