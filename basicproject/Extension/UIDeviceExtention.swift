//
//  UIDeviceExtention.swift
//  FPVGreat
//
//  Created by UPC3965 on 2020/12/7.
//

import UIKit

extension UIDevice{
    public func deviceMandatoryLandscapeWithNewOrientation(interfaceOrientation:UIInterfaceOrientation){
        UIDevice.current.setValue(NSNumber.init(value: UIInterfaceOrientation.unknown.rawValue), forKey: "orientation")
        UIDevice.current.setValue(NSNumber.init(value: interfaceOrientation.rawValue), forKey: "orientation")
    }
}
