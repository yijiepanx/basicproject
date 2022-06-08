//
//  UIView+Extension.swift
//  Vape
//
//  Created by Shawn on 2018/9/6.
//  Copyright © 2018年 ChenJianglin. All rights reserved.
//

import UIKit

enum VPCorner {
    case left
    case right
    case top
    case bottom
    case all
    case diagonal_top_bottom
    case diagonal_bottom_top
    case bottomRight
}

extension UIView {
    
    /// 截屏
    func takeScreenShot() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    /// 截屏
    func takeScreenShotToView() -> UIView? {
        if let snapshotImage = takeScreenShot() {
            return UIImageView(image: snapshotImage)
        } else {
            return nil
        }
    }
    
    /// 切圆
    func clipToCircle(radius: CGFloat) {
        let cornerSize = CGSize(width: radius, height: radius)
        let maskPath = UIBezierPath(roundedRect: CGRect.init(x: 0,y: 0,width: radius , height: radius), byRoundingCorners: .allCorners, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    /// 设置圆角
    func setCorner(cornerType: VPCorner, cornerRadius radius: CGFloat,backColor:UIColor? = nil) {
        
        var maskPath = UIBezierPath()
        
        switch cornerType {
        case .left:
            maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: radius, height: radius))
        case .right:
            maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        case .top:
            maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        case .bottom:
            maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        case .all:
            maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        case .bottomRight:
            maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        case .diagonal_top_bottom:
            maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft,.bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        case .diagonal_bottom_top:
            maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft,.topRight], cornerRadii: CGSize(width: radius, height: radius))
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        if let bColor = backColor {
            maskLayer.fillColor = bColor.cgColor
        }
        self.layer.mask = maskLayer
    }
}

extension UIView {
    
    /// 子视图列表
    func listSubViews() -> [UIView] {
        
        var subViewArray: [UIView] = []
        let subViews = self.subviews
        subViewArray += subViews
        guard !subViewArray.isEmpty else { return subViewArray}
        
        for subView in subViewArray {
            subViewArray += subView.listSubViews()
        }
        return subViewArray
    }
}

extension UIView {
    
    /// 判断当前视图是否在keyWindows上显示
    func isShowingOnKeyWindow() -> Bool {
        
        let keyWindow = UIApplication.shared.keyWindow!
        //        let newFrame = keyWindow.convert(self.frame, from: self.superview)
        var newFrame = convert(self.frame, from: nil)
        if let superview = self.superview {
            newFrame = superview.convert(self.frame, to: self.window)
        }
        let isZeroFrame = newFrame == .zero
        let windbounds = UIScreen.main.bounds
        let intersects = newFrame.intersects(windbounds)
        
        return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects && self.window != nil && !isZeroFrame
    }
    
}


enum VPBorderDirectionType {
    case top
    case left
    case right
    case bottom
}

extension UIView {
    
    /// 给一个view加边框
    ///
    /// - Parameters:
    ///   - directon: 那个方向上加
    ///   - color: 要加的线的颜色
    ///   - width: 要加的线的宽度
    func addBorder(directon: VPBorderDirectionType, color: UIColor, width: CGFloat){
        let border = CALayer()
        border.backgroundColor = color.cgColor
        switch directon {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: width)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.bounds.size.height)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.bounds.size.height - width, width: self.bounds.size.width, height: width)
        case .right:
            border.frame = CGRect(x: self.bounds.size.width - width, y: 0, width: width, height: self.bounds.size.height)
        }
        self.layer.addSublayer(border)
    }
    
    public var boundsCenter: CGPoint {
        
        return CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    }
    
    func frame(inCoordinatesOfView parentView: UIView) -> CGRect {
        
        let frameInWindow = UIApplication.applicationWindow!.convert(self.bounds, from: self)
        return parentView.convert(frameInWindow, from: UIApplication.applicationWindow)
    }
    
    func addSubviews(_ subviews: UIView...) {
        
        for view in subviews { self.addSubview(view) }
    }
    
    static func animateWithDuration(_ duration: TimeInterval, delay: TimeInterval, animations: @escaping () -> Void) {
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions(), animations: animations, completion: nil)
    }
    
    static func animateWithDuration(_ duration: TimeInterval, delay: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions(), animations: animations, completion: completion)
    }
    static func cell(of view: UIView)->UITableViewCell?{
        var next:UIView? = view
        repeat{
            if let nextResponder = next?.next, nextResponder is UITableViewCell {
                return (nextResponder as! UITableViewCell)
            }
            next = next?.superview
        }while next != nil
        return nil
    }
    /// 根据cell找到对应的tableview
    static func tableView(of view: UIView)->UITableView?{
        var next:UIView? = view
        repeat{
            if let nextResponder = next?.next, nextResponder is UITableView {
                return (nextResponder as! UITableView)
            }
            next = next?.superview
        }while next != nil
        return nil
    }
    static func collectionView(of view: UIView)->UICollectionView?{
        var next:UIView? = view
        repeat{
            if let nextResponder = next?.next, nextResponder is UICollectionView {
                return (nextResponder as! UICollectionView)
            }
            next = next?.superview
        }while next != nil
        return nil
    }
    static func collectionCell(of view: UIView)->UICollectionViewCell?{
        var next:UIView? = view
        repeat{
            if let nextResponder = next?.next, nextResponder is UICollectionViewCell {
                return (nextResponder as! UICollectionViewCell)
            }
            next = next?.superview
        }while next != nil
        return nil
    }
}

extension UIView {
    
    var x: CGFloat {
        get { return self.frame.origin.x }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var y: CGFloat {
        get { return self.frame.origin.y }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var width: CGFloat {
        get { return self.frame.size.width }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get { return self.frame.size.height }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var size: CGSize  {
        get { return self.frame.size }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    var origin: CGPoint {
        get { return self.frame.origin }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    var centerX: CGFloat {
        get { return self.center.x }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    var centerY: CGFloat {
        get { return self.center.y }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    var top : CGFloat {
        get { return self.frame.origin.y }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var bottom : CGFloat {
        get { return frame.origin.y + frame.size.height }
        set {
            var frame = self.frame
            frame.origin.y = newValue - self.frame.size.height
            self.frame = frame
        }
    }
    
    var left : CGFloat {
        get { return self.frame.origin.x }
        set {
            var frame = self.frame
            frame.origin.x  = newValue
            self.frame = frame
        }
    }
    
    var right : CGFloat {
        get { return self.frame.origin.x + self.frame.size.width }
        set {
            var frame = self.frame
            frame.origin.x = newValue - self.frame.size.width
            self.frame = frame
        }
    }
}

