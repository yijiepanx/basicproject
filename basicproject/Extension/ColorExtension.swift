//
//  ColorExtension.swift
//  SalonPro
//
//  Created by 潘艺杰 on 2020/8/12.
//  Copyright © 2020 pyj. All rights reserved.
//

import UIKit


// MARK: - 颜色扩展
extension UIColor {
    class func RGB(r : CGFloat, g : CGFloat, b : CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    class func RGBA(r : CGFloat, g : CGFloat, b : CGFloat, a : CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    class func HexA(hexValue : Int, a : CGFloat) -> UIColor {
        return UIColor(red: CGFloat(((hexValue & 0xFF0000) >> 16)) / 255.0,
                       green: CGFloat(((hexValue & 0xFF00) >> 8)) / 255.0,
                       blue: CGFloat((hexValue & 0xFF)) / 255.0, alpha: a)
    }
    
    class func Hex(hexValue : Int) -> UIColor {
        return HexA(hexValue: hexValue, a: 1)
    }
    
    
    class func HexString(hexString: String) -> UIColor{
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    
    
    //随机颜色
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random()%256) / 255.0,
                       green: CGFloat(arc4random()%256) / 255.0,
                       blue: CGFloat(arc4random()%256) / 255.0,
                       alpha: 1)
    }
}


// app自定义
// x-fly
let kPrimaryBlack = UIColor.Hex(hexValue: 0x0D0D0D) //app主背景 黑色






//let kPrimaryColor = UIColor.Hex(hexValue: 0xF1017F) //app主色调 玫红
//let kPrimaryColor = UIColor.Hex(hexValue: 0x3C7983) //app主色调 墨绿

//let kRedColor_F13 = UIColor.Hex(hexValue: 0xF11313) //app主色调 红色
//let kRedColor_FF00 = UIColor.Hex(hexValue: 0xF11313) //app主色调 价格颜色
//let kRedColor_F33 = UIColor.Hex(hexValue: 0xFF3333)
//
//let kGreenColor_light = UIColor.Hex(hexValue: 0x00CC99) //app绿色 #00CC99
//
//let kGrayColor_33 = UIColor.Hex(hexValue: 0x333333) //字体 灰色33
//let kGrayColor_66 = UIColor.Hex(hexValue: 0x666666) //字体 黑色66
//let kGrayColor_82 = UIColor.Hex(hexValue: 0x828282) //字体 灰色82
//let kGrayColor_99 = UIColor.Hex(hexValue: 0x999999) //字体 灰色99
//
//let kGrayColor_CC = UIColor.Hex(hexValue: 0xCCCCCC) //背景灰色 cc
//let kGrayColor_F7 = UIColor.Hex(hexValue: 0xF5F5F5) //背景灰色  //全局转为F5
