//
//  OKBaseNavigationController.swift
//  okart
//
//  Created by panyijie on 2022/5/17.
//

import UIKit

class OKBaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        
        navigationBar.backgroundColor = UIColor.init(hexString: "#0D0D0D")
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0xffffff)]
        navigationBar.barTintColor = UIColor.white
        navigationBar.setBackgroundImage(UIColor.creatImageWithColor(color: UIColor.init(hexString: "#0D0D0D")), for: UIBarPosition.any, barMetrics: .default)

        navigationBar.shadowImage = UIImage()
        self.navigationBar.tintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.white
        
        self.delegate = self
        
        adjustSystemUpdate()
        
        interactivePopGestureRecognizer?.delegate = self
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override var shouldAutorotate: Bool{
        return self.topViewController?.shouldAutorotate ?? false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return self.topViewController?.supportedInterfaceOrientations ?? .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return self.topViewController?.preferredInterfaceOrientationForPresentation ?? UIInterfaceOrientation.portrait
    }
    
    private func adjustSystemUpdate() {
        
        if #available(iOS 15.0, *) {
            let barApp = UINavigationBarAppearance()
            barApp.backgroundColor = UIColor.init(hexString: "#0D0D0D") //0D0D0D
            barApp.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0xffffff)]

            self.navigationBar.scrollEdgeAppearance = barApp
            self.navigationBar.standardAppearance = barApp

        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: self, action: #selector(cl_backToPreViewController))
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc func cl_backToPreViewController(){
        popViewController(animated: true)
    }
    
}

extension OKBaseNavigationController: UIGestureRecognizerDelegate {
    // 让边缘侧滑手势在合适的情况下生效
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (self.viewControllers.count > 1) {
            return true;
        }
        return false;
    }
    
    // 允许同时响应多个手势
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {        return true
    }
    
    // 避免响应边缘侧滑返回手势时，当前控制器中的ScrollView跟着滑动
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
    }
}
