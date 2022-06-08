//
//  UIViewController+PresentWebVC.swift
//  FPVGreat
//
//  Created by youzu on 2020/11/12.
//

import UIKit

extension NSObject {
    
//    func pushWebVC(url: String, configBlock:((WebBridgeWebVC)->())? = nil) {
//        if let url = URL.init(string: url) {
//            let webVC = WebBridgeWebVC.init(url: url)
//            configBlock?(webVC)
//            let topNav = UIViewController.topMost?.navigationController
//            topNav?.pushViewController(webVC, animated: true)
//        }
//
//    }
    
    //跳转到对应页面或者开启一个新页面
    func pushViewController<T: UIViewController>(nav: UINavigationController?, initVCBloack: (()->T)?, type: T.Type, block: ((UIViewController, Bool)->Void)? = nil, completeBlock: ((UIViewController)->Void)? = nil){
        guard let controllers = nav?.viewControllers else{
            return
        }
        var isHas: Bool = false
        for viewController in controllers{
            if viewController is T, let vc = viewController as? T {
                isHas = true
                block?(vc, true)
                nav?.popToViewController(vc, animated: false)
                completeBlock?(vc)
                break
            }
        }
        if !isHas{
            guard let vc = initVCBloack?() else { return }
            block?(vc, false)
            nav?.pushViewController(vc, animated: true)
            completeBlock?(vc)
        }
    }
    
    public func createController(_ className: String) -> UIViewController?{
        if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
                let classStringName = appName + "." + className
                let cls: AnyClass? = NSClassFromString(classStringName)
                guard let clsType = cls as? UIViewController.Type else {
                    return nil
                }
                let VC = clsType.init()
                return VC
            }
        return nil
    }
}

