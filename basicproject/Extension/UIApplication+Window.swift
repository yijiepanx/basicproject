//
//  UIApplication+Window.swift
//  FPVGreat
//
//  Created by youzu on 2020/11/13.
//

import UIKit

extension UIApplication {
    static var applicationWindow: UIWindow? {
//        if #available(iOS 13.0, *) {
//            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
//                return nil
//            }
//            return sceneDelegate.window
//        }else{
            return (UIApplication.shared.delegate?.window?.flatMap { $0 })
//        }
    }
    
    //delegate
    static var applicationdelegate: AppDelegate? {
         let delegate = UIApplication.shared.delegate as? AppDelegate
         return delegate
    }
}

