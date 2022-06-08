//
//  ViewExtension.swift
//  SalonPro
//
//  Created by 潘艺杰 on 2020/8/27.
//  Copyright © 2020 pyj. All rights reserved.
//

import UIKit

typealias CornersRadius = (topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat)

extension UIView {

    //创建Path
    func createPath(bounds:CGRect, cornersRadius:CornersRadius) -> CGPath {
            let minX = bounds.minX
            let minY = bounds.minY
            let maxX = bounds.maxX
            let maxY = bounds.maxY

            let topLeftCenterX = minX + cornersRadius.topLeft
            let topLeftCenterY = minY + cornersRadius.topLeft
            let topRightCenterX = maxX - cornersRadius.topRight
            let topRightCenterY = minY + cornersRadius.topRight
            let bottomLeftCenterX = minX + cornersRadius.bottomLeft
            let bottomLeftCenterY = maxY - cornersRadius.bottomLeft
            let bottomRightCenterX = maxX - cornersRadius.bottomRight
            let bottomRightCenterY = maxY - cornersRadius.bottomRight
            
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: topLeftCenterX, y: topLeftCenterY), radius: cornersRadius.topLeft, startAngle: CGFloat(Double.pi), endAngle: CGFloat(3 * Double.pi / 2.0), clockwise: false)
            path.addArc(center: CGPoint(x: topRightCenterX, y: topRightCenterY), radius: cornersRadius.topRight, startAngle: CGFloat(3 * Double.pi / 2.0), endAngle: 0, clockwise: false)
            path.addArc(center: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY), radius: cornersRadius.bottomRight, startAngle: 0, endAngle: CGFloat(Double.pi / 2.0), clockwise: false)
            path.addArc(center: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY), radius: cornersRadius.bottomLeft, startAngle: CGFloat(Double.pi / 2.0), endAngle: CGFloat(Double.pi), clockwise: false)
            path.closeSubpath()
            
            return path
    }
    //切圆角
    func cornerClip(corner : UIRectCorner ,clipSize : CGFloat) {
        self.layoutIfNeeded()
        
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: clipSize, height: clipSize))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
      
    }
    
    //设置border
    /**
     CAShapeLayer *borderLayer = [CAShapeLayer layer];
     borderLayer.frame = view.bounds;
     borderLayer.path = path.CGPath;
     borderLayer.lineWidth = borderWidth;
     borderLayer.fillColor = [UIColor clearColor].CGColor;
     borderLayer.strokeColor = borderColor.CGColor;
     [view.layer addSublayer:borderLayer];
     */
    func borderSet(width : CGFloat,color : UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func borderLayerSet(width : CGFloat,color : UIColor) {
        let cornerRad: CornersRadius = (0,10,20,0)
        let patht = createPath(bounds: bounds, cornersRadius: cornerRad)
        //添加border
        let borderLayer = CAShapeLayer()
        borderLayer.frame = bounds
        borderLayer.path = patht
        borderLayer.lineWidth = width
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color.cgColor
        self.layer.addSublayer(borderLayer)
    }
    
}
// MARK: -  进行一个视图的渐变
// UIView 渐变色 , UIView及其子类都可以使用，比如UIButton、UILabel等。
// Usage:
// myButton.gradientColor(CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5), [UIColor(hex: "#FF2619").cgColor, UIColor(hex: "#FF8030").cgColor])
extension UIView {
    
    // MARK: 添加渐变色图层
   func gradientColor(_ startPoint: CGPoint, _ endPoint: CGPoint, _ colors: [Any]) {
        
        guard startPoint.x >= 0, startPoint.x <= 1, startPoint.y >= 0, startPoint.y <= 1, endPoint.x >= 0, endPoint.x <= 1, endPoint.y >= 0, endPoint.y <= 1 else {
            return
        }
        
        // 外界如果改变了self的大小，需要先刷新
        layoutIfNeeded()
        
        var gradientLayer: CAGradientLayer!
        
        removeGradientLayer()

        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.layer.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
        // self如果是UILabel，masksToBounds设为true会导致文字消失
        self.layer.masksToBounds = false
    }
    
    // MARK: 移除渐变图层
    // （当希望只使用backgroundColor的颜色时，需要先移除之前加过的渐变图层）
    func removeGradientLayer() {
        if let sl = self.layer.sublayers {
            for layer in sl {
                if layer.isKind(of: CAGradientLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
}

extension UIView{  //获取view所在controller

    func getFirstViewController()->UIViewController?{

        for view in sequence(first: self.superview, next: {$0?.superview}){

            if let responder = view?.next{

                if responder.isKind(of: UIViewController.self){

                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    func screenShot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.frame.size,false,UIScreen.main.scale)

        self.layer.render(in:UIGraphicsGetCurrentContext()!)

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image!
//        UIImageWriteToSavedPhotosAlbum(image!,self,nil,nil)
    }
}
