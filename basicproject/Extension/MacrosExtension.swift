//
//  FuncExtension.swift
//  RecruitmentX
//
//  Created by 潘艺杰 on 2020/7/14.
//  Copyright © 2020 潘艺杰. All rights reserved.
//

import UIKit
/*
 Swift中不存在宏定义常量或者方法
 使用自定义类实现类似定义便捷常量或者扩展方法
 
 部分方法扩展采用扩展该类的类方法方式，统一写于此处
 */

// MARK: -  系统尺寸相关
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenBounds = UIScreen.main.bounds

/**
 ## 状态栏高度
 ## 刘海屏时高度为：34，非刘海屏高度为20
 */
let kNavBarHright :CGFloat = 44.0

let kTopNavBarHeight = kStatusBarHeight + kNavBarHright
/**
 ## 此处使用刘海屏的状态栏高度不同判断
 ## 刘海屏时tabbar高度为83（增加了安全区域高度），非时为49（tabbar容器真实高度）
 */
let kTabbarHeight : CGFloat = kStatusBarHeight > 20 ? 83.0 : 49.0


let KIsPhoneX : Bool = kStatusBarHeight > 20 ? true : false

/**
 ## 底部安全区域高度，刘海屏时为34
 */
let kBottomSafeAreaHeight :CGFloat = kStatusBarHeight > 20 ? 34 : 0


//用于部分适配，采用屏幕比例 以iPhone6尺寸（375*667）为标准
//数据类型为CGFloat
let kIPhone6WidthScale : CGFloat = (kScreenWidth / 375.0)
let kIPhone6HeightScale : CGFloat = (kScreenHeight / 667.0)

/**
 根据iPhone6宽度计算拉伸后数值
 此处可根据需求修改拉伸参数  待添加
 */
func kScaleValue(originValue : CGFloat) -> CGFloat {
    return originValue * kIPhone6WidthScale
}



// MARK: -  


