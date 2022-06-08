//
//  Device+Extension.swift
//  FPVGreat
//
//  Created by youzu on 2020/11/13.
//

import UIKit
let kStatusBarHeight = UIDevice.statusBarHeight()

extension UIDevice {
  
    static func statusBarHeight() ->CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *){
            let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
            statusBarHeight = statusBarManager?.statusBarFrame.size.height ?? 20
        }else{
            statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        }
        return statusBarHeight
    }
    
    static func safeBottomHeight() -> CGFloat {
        if #available(iOS 13.0, *){
            let bottomHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
            return bottomHeight
        }else{
            return 0
        }
    }
    
    static var isPhoneX: Bool {
        if let currentMode = UIScreen.main.currentMode {
            let ratioSize = Int((currentMode.size.height/currentMode.size.width)*100)
            return ( ratioSize == 216)
        }else{
            return false
        }
    }
    
    
}
