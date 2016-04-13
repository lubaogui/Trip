//
//  GuideViewController.swift
//  Trip
//
//  Created by Baogui Lu on 4/9/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {
    
    let pageControl = UIPageControl();
    let startButton = UIButton(type: UIButtonType.System);
    
    var guideImages: Array<String>?;
    
    private let scrollView: UIScrollView = UIScrollView();

    override func viewDidLoad() {
        super.viewDidLoad();
        
        scrollView.frame = self.view.bounds;
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        guideImages = ["guide_1", "guide_2", "guide_3", "guide_4"];
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(guideImages!.count), height: scrollView.frame.size.height);
        scrollView.delegate = self;
        
        
        for  (index, guideImage) in guideImages!.enumerate() {
            // 这里注意图片的命名
            let imageView = UIImageView(image: UIImage(named: guideImage));
            imageView.frame = CGRect(x: scrollView.frame.size.width * CGFloat(index), y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
            imageView.userInteractionEnabled = true;
            scrollView.addSubview(imageView);
        }
        scrollView.contentOffset = CGPointZero;
        scrollView.userInteractionEnabled = true;
        self.view.insertSubview(scrollView, atIndex: 0);
        



        startButton.frame = CGRect(x: self.view.frame.size.width/2-50, y: self.view.frame.size.height-100, width: 150, height: 30);
        startButton.center.x = self.view.frameWidth/2;
        startButton.backgroundColor = UIColor.blueColor();
        startButton.layer.cornerRadius = 5.0;
        // 隐藏开始按钮
        startButton.alpha = 0;
        startButton.setTitle("开启Hug之旅", forState: UIControlState.Normal);
        startButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        startButton.backgroundColor = UIColor.redColor();
        startButton.addTarget(self, action: #selector(GuideViewController.guideViewFinished), forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(startButton);

        //设置pageControl属性
        self.pageControl.numberOfPages = (self.guideImages?.count)!;
        self.view.addSubview(pageControl);
        self.pageControl.center = startButton.center;

        // Do any additional setup after loading the view.
    }
    
    
    func guideViewFinished(sender: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName("guideViewFinished", object: nil);
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


// MARK: - UIScrollViewDelegate
extension GuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset;
        
        // 随着滑动改变pageControl的状态
        self.pageControl.currentPage = Int(offset.x / view.bounds.width);
        
        // 因为currentPage是从0开始，所以numOfPages减1
        if pageControl.currentPage == self.guideImages!.count - 1 {
            self.pageControl.hidden = true;
            UIView.animateWithDuration(0.5) {
                self.startButton.alpha = 0.8;
            }
        } else {
            self.pageControl.hidden = false;
            UIView.animateWithDuration(0.2) {
                self.startButton.alpha = 0.0;
            }
        }
    }
}
