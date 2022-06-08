//
//  OKTabBarController.swift
//  okart
//
//  Created by panyijie on 2022/5/17.
//

import UIKit
import ESTabBarController_swift

class OKTabBarController: ESTabBarController, UITabBarControllerDelegate {
    
//    var loginService = LoginService()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        adjustSystemUpdate()
        self.view.backgroundColor = kPrimaryBlack
        self.tabBar.shadowImage = nil
        
        if let tabBar = self.tabBar as? ESTabBar {
//            tabBar.itemCustomPositioning = .fillIncludeSeparator
            tabBar.backgroundImage = UIColor.creatImageWithColor(color: UIColor.init(hexString: "#181818"))
//            tabBar.isTranslucent = true
//            tabBar.isOpaque = true
//            tabBar.itemEdgeInsets = UIEdgeInsets.init(top: 20, left: 0, bottom: 20, right: 0)
//            tabBar.itemCustomPositioning = .automatic
        }
        
//        self.shouldHijackHandler = { (tabbarController, viewController, index) in
//            if index == 2 {
//                UMobClickManager.eventAction(with: .page_app_release_button_click)
//
//                self.loginService.checkLoginAndShowLoginVC { finish in
//                    if finish {
//                        FPVForumUploadService().adapterShow()
//                    }
//                }
//                return true
//            } else {
//                print("tab hijack")
//                return false
//            }
//        }
        
       

        
    }
    
    private func adjustSystemUpdate() {
        
        if #available(iOS 15.0, *) {
            let barapp = UINavigationBarAppearance()
            barapp.backgroundColor = UIColor.init(hexString: "#181818")
            self.moreNavigationController.navigationBar.scrollEdgeAppearance = barapp
            self.moreNavigationController.navigationBar.standardAppearance = barapp
        }
        self.moreNavigationController.navigationBar.isOpaque = false
        self.moreNavigationController.navigationBar.isTranslucent = false
        
        
        if #available(iOS 15.0, *) {
            let barApp = UITabBarAppearance()
            barApp.backgroundColor = UIColor.init(hexString: "#181818")
            
            self.tabBar.scrollEdgeAppearance = barApp
            self.tabBar.standardAppearance = barApp

        }
    }
    
    func showLoginForVC(vc: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: vc) else {
            return false
        }
        switch index {
        case 1...:
            return !SSaiLoginManager.isUserLogin
        default:
            return false
        }
    }
    
    func getIndexForVC(vc: UIViewController) -> Int {
        guard let index = viewControllers?.firstIndex(of: vc) else {
            return -1
        }
        return index
    }
    
    func showEventAction(vc: UIViewController) {
//        guard let index = viewControllers?.firstIndex(of: vc) else {
//
//            return
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.selectedViewController?.viewDidAppear(animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let currentVc = tabBarController.selectedViewController
        if currentVc == viewController { }
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        showEventAction(vc: viewController)
    }
    
    override var shouldAutorotate: Bool{
        if  (self.selectedViewController as? OKBaseNavigationController) != nil {
            return self.selectedViewController?.shouldAutorotate ?? false
        }
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        if  (self.selectedViewController as? OKBaseNavigationController) != nil {
            return self.selectedViewController?.supportedInterfaceOrientations ?? UIInterfaceOrientationMask.portrait
        }
        return UIInterfaceOrientationMask.portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        if  (self.selectedViewController as? OKBaseNavigationController) != nil {
            return self.selectedViewController?.preferredInterfaceOrientationForPresentation ?? UIInterfaceOrientation.portrait
        }
        return UIInterfaceOrientation.portrait
    }
    
}

extension OKTabBarController {
    
    static func createTabBarController() -> OKTabBarController{
        let tabBarController = OKTabBarController()
        
        //首页模块
        let homeVC = OKHomeController()
        homeVC.title = "首页"
        homeVC.tabBarItem = ESTabBarItem.init(BaseCustomTabContent(), title: "首页", image: UIImage(named: "ok_tabbar_home_normal"), selectedImage: UIImage(named: "ok_tabbar_home_selected"))
        let homeVCNav = OKBaseNavigationController(rootViewController: homeVC)

        
        tabBarController.viewControllers = [homeVCNav]
        tabBarController.delegate = tabBarController
        return tabBarController
    }
    
    
}
