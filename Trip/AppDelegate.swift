//
//  AppDelegate.swift
//  Trip
//
//  Created by Baogui Lu on 3/15/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?;
    
    //根tabBarVC
    var tabBarVC: LBTabBarController?;
    var referrenceVC: UIViewController?;
    var targetVC: UIViewController?;
    
    //用户流程在此程序中开始
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds);

        //注册本地通知
        self.registerNotifications();
    
        //判断是否该版本的第一次启动
        if isVersionFirstLaunch() == true {
            print("Guide is begining");
            self.window?.rootViewController = GuideViewController();
        }
        else {
            self.window?.rootViewController = getTabBarVC();
        }
        
        self.window?.backgroundColor = UIColor.whiteColor();
        self.window?.makeKeyAndVisible();
        return true
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.lubanr.Trip" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Trip", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}


//版本信息扩展
extension AppDelegate {
    //是否是该版本的第一次启动
    func isVersionFirstLaunch() -> Bool {
        // 得到当前应用的版本号
        let infoDictionary = NSBundle.mainBundle().infoDictionary;
        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String;
        
        // 取出之前保存的版本号
        let userDefaults = NSUserDefaults.standardUserDefaults();
        let appVersion = userDefaults.stringForKey("appVersion");
        
        if appVersion == nil || appVersion != currentAppVersion {
            // 保存最新的版本号
            userDefaults.setValue(currentAppVersion, forKey: "appVersion");
            return true;
        }
        else {
            return false;
        }
    }
    
}


//设置通知和相关的动作处理函数
extension AppDelegate {
    //设置通知
    private func registerNotifications()  {
        let notificationCenter = NSNotificationCenter.defaultCenter();
        
        //需要登录通知，该通知只在网络请求等一些情况下使用
        notificationCenter.addObserver(self, selector: #selector(AppDelegate.needLogin(_:)), name: "needLoginNotification", object: nil);
        
        //登录成功通知
        notificationCenter.addObserver(self, selector: #selector(AppDelegate.didLoginSucceeded(_:)), name: "LoginSucceededNotifycation", object: nil);
        notificationCenter.addObserver(self, selector: #selector(AppDelegate.didLogoutSucceeded(_:)), name: "LogoutSucceededNotifycation", object: nil);
        notificationCenter.addObserver(self, selector: #selector(AppDelegate.guideViewFinished(_:)), name: "guideViewFinished", object: nil);
        
    }
    
    //当需要用户登录时调用登录界面，此方法需要记录用户登录之前的页面，在登录成功后需要跳转到原页面
    func needLogin(notification:NSNotification) {
        
    }
    
    
    //登陆成功之后界面需要做的附加动作
    func didLoginSucceeded(notification: NSNotification) {
        
    }
    
    //退出成功之后界面需要做的附加动作
    func didLogoutSucceeded(notification: NSNotification) {
        
    }
    
    //引导过程结束之后的操作,可定制
    func guideViewFinished(notification: NSNotification) {
        self.window?.rootViewController = self.getTabBarVC();
    }
    
}


