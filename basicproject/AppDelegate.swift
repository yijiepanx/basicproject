//
//  AppDelegate.swift
//  basicproject
//
//  Created by iOS_dev on 2022/6/7.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func scrollViewContentInsetConfig()  {
        /**
         全局修正scrollview的contentInset偏差
         不采用自有AdjustmentBehavior，页面内具体情况由显示页面调整
         */
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            UIViewController().automaticallyAdjustsScrollViewInsets = false
        }
        
        /**
         适配iOS15.0 tableview sectionHeader新增偏移量
         */
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        
    }
    /**
      修改默认present页面为全屏样式
     */
    func modelPresentStyleChanged() {
        if #available(iOS 13.0, *) {
//            UIViewController.swizzlePresent()
        }
    }

}

