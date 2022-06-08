//
//  BaseCustomTabContent.swift
//  SalonPro
//
//  Created by 潘艺杰 on 2020/11/12.
//  Copyright © 2020 pyj. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class BaseCustomTabContent: ESTabBarItemContentView {

    public var duration = 0.2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderingMode = .alwaysOriginal //开启采用icon原图色
        textColor = UIColor.Hex(hexValue: 0xA4A7AB)
        highlightTextColor = .white
//        iconColor = UIColor.init(white: 165.0 / 255.0, alpha: 1.0)
//        highlightIconColor = .white
//        backdropColor = .white
//        highlightBackdropColor = UIColor.init(red: 22/255.0, green: 24/255.0, blue: 25/255.0, alpha: 1.0)
        
        let transform = CGAffineTransform.identity
        imageView.transform = transform.scaledBy(x: 1, y: 1)

    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
//        UIView.beginAnimations("small", context: nil)
//        UIView.setAnimationDuration(0.2)
//        let transform = imageView.transform.scaledBy(x: 0.8, y: 0.8
//        )
//        imageView.transform = transform
//        UIView.commitAnimations()
//        completion?()
//    }
//
//    override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
//        UIView.beginAnimations("big", context: nil)
//        UIView.setAnimationDuration(0.2)
//        let transform = CGAffineTransform.identity
//        imageView.transform = transform.scaledBy(x: 1, y: 1)
//        UIView.commitAnimations()
//        completion?()
//    }
    
//    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
//        self.bounceAnimation()
//        completion?()
//    }
//
//    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
//        self.bounceAnimation()
//        completion?()
//    }
//
//    func bounceAnimation() {
//        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
//        impliesAnimation.values = [1.0 , 0.9, 0.95, 1.0]
//        impliesAnimation.duration = duration
//        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
//        imageView.layer.add(impliesAnimation, forKey: nil)
//    }

}
