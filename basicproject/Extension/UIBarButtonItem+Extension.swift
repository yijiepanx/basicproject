//
//  UIBarButtonItem+Extension.swift
//  SwiftExperience
//
//  Created by Shawn on 2018/9/5.
//  Copyright © 2018年 Shawn. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // 限制的最小宽高
    static let minWH: CGFloat = 44.0
    
    
    static let lessminWH: CGFloat = 36.0
    
    /// 快速创建指定宽度的弹簧UIBarButtonItem
    ///
    /// - Parameter width: 指定宽度
    static func fixedSpace(spaceWidth width: CGFloat) -> UIBarButtonItem {
        
        let item = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        item.width = width
        return item
    }
    
    
    
    /// 快速创建UIBarButtonItem 显示的是文字
    ///
    /// - Parameters:
    ///   - title: 显示文字 使用的是系统字体颜色
    ///   - fontSize: 文字大小 默认16号字
    convenience init(title: String, fontSize: CGFloat = 16.0, contentInset: UIEdgeInsets = UIEdgeInsets.zero, isLimitMinSize: Bool = false, isSemibold: Bool = true, target: Any? = nil, action: Selector? = nil) {
        
        let button = UIButton(type: .custom)
        if isSemibold {
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
        button.setTitle(title, for: .normal)
        if let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        button.sizeToFit()
        button.width = button.width + contentInset.left + contentInset.right
        button.height = button.top + contentInset.left + contentInset.bottom
        if isLimitMinSize {
            button.width = (button.width > UIBarButtonItem.minWH) ? button.width : UIBarButtonItem.minWH
            button.height = (button.height > UIBarButtonItem.minWH) ? button.height : UIBarButtonItem.minWH
        }
        self.init(customView: button)
    }
    
    
    
    /// 快速创建UIBarButtonItem 显示的是文字
    ///
    /// - Parameters:
    ///   - title: 正常title
    ///   - fontSize: 文字大小 默认16号字
    ///   - normalColor: 正常文字颜色 默认黑色
    ///   - highColor: 高亮文字颜色
    ///   - disabColor: 禁止交互文字颜色
    convenience init(title: String, fontSize: CGFloat = 16.0, normalColor: UIColor = UIColor.black, highColor: UIColor? = nil, disabColor: UIColor? = nil, contentInset: UIEdgeInsets = UIEdgeInsets.zero, isLimitMinSize: Bool = false, isSemibold: Bool = true, target: Any? = nil, action: Selector? = nil) {
        
        let button = UIButton(type: .custom)
        if isSemibold {
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(normalColor, for: .normal)
        if highColor != nil {
            button.setTitleColor(highColor, for: .highlighted)
        }
        if disabColor != nil {
            button.setTitleColor(disabColor, for: .disabled)
        }
        if let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        
        button.sizeToFit()
        button.width = button.width + contentInset.left + contentInset.right
        button.height = button.height + contentInset.left + contentInset.bottom
        if isLimitMinSize {
            button.width = (button.width > UIBarButtonItem.minWH) ? button.width : UIBarButtonItem.minWH
            button.height = (button.height > UIBarButtonItem.minWH) ? button.height : UIBarButtonItem.minWH
        }
        self.init(customView: button)
    }
    
    /// 快速创建UIBarButtonItem 显示的是图片
    ///
    /// - Parameters:
    ///   - image: 正常图片
    ///   - highImage: 高亮图片
    ///   - selectedImage: 选中图片
    ///   - disabledImage: 禁止交互图片
    convenience init(image: String, highImage: String? = nil, selectedImage: String? = nil, disabledImage: String? = nil, contentInset: UIEdgeInsets = UIEdgeInsets.zero, isLimitMinSize: Bool = false, target: Any? = nil, action: Selector? = nil) {
        
        let button = BaseButton(type: .custom)
        button.setImage(UIImage(named: image), for: .normal)
        if let highImage = highImage {
            button.setImage(UIImage(named: highImage), for: .highlighted)
        }
        if let selectedImage = selectedImage {
            button.setImage(UIImage(named: selectedImage), for: .selected)
        }
        if let disabledImage = disabledImage {
            button.setImage(UIImage(named: disabledImage), for: .disabled)
        }
        if let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        
        button.sizeToFit()
        
        button.width = button.width + contentInset.left + contentInset.right
        button.height = button.height + contentInset.left + contentInset.bottom
        if isLimitMinSize {
            button.width = (button.width > UIBarButtonItem.minWH) ? button.width : UIBarButtonItem.minWH
            button.height = (button.height > UIBarButtonItem.minWH) ? button.height : UIBarButtonItem.minWH
        }
        
        //        let containView = UIView(frame: button.bounds)
        //        containView.addSubview(button)
        
        self.init(customView: button)
    }
    
    
}

extension UIBarButtonItem{
    
    /// 快速根据图片名创建系统 UIBarButtonItem 默认 .plain 样式
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - renderMode: 图片渲染mode
    ///   - style: UIBarButtonItem 样式
    convenience init(imageName: String, renderMode: UIImage.RenderingMode = .alwaysOriginal, style: UIBarButtonItem.Style = .plain, target: Any? = nil, action: Selector? = nil) {
        let image = UIImage(named: imageName)?.withRenderingMode(renderMode)
        self.init(image: image, style: style, target: target, action: action)
    }
}

