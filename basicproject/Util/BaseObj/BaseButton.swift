//
//  BaseButton.swift
//  Vape
//
//  Created by Levin on 2017/5/24.
//  Copyright © 2017年 范国徽. All rights reserved.
//

import UIKit
//import TimedSilver

class BaseButton: UIButton {

    enum ShowType {
        case normal(color: UIColor)
        case gradient(colors: [UIColor])
    }
    static let normalColor: UIColor =  UIColor.init(hexString: "#3B3C49")
    
    static let normalGradient: [UIColor] = [UIColor.init(hexString: "#FD1A4C"), UIColor.init(hexString: "#FF4D54")]
    /// 渐变色：默认从上到下
    private var gradientLayer: CAGradientLayer = {
        let g = CAGradientLayer()
        let colors = [UIColor.init(hexString: "#FD1A4C"), UIColor.init(hexString: "#FF4D54")]
        g.colors = colors.map { $0.cgColor }
        //改为从左到右 的渐变
        g.startPoint = CGPoint(x: 0, y: 0.5)
        g.endPoint = CGPoint(x: 1.0, y: 0.5)
        g.locations = [0, 1]
        g.isHidden = true
        return g
    }()
    
    var startPoint: CGPoint = CGPoint(x: 0, y: 0.5) {
        didSet{
            gradientLayer.startPoint = startPoint
            layoutIfNeeded()
        }
    }
    
    var endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5) {
        didSet{
            gradientLayer.endPoint = endPoint
            layoutIfNeeded()
        }
    }
    
    var gradientcolors: [CGColor] = [] {
        didSet{
            gradientLayer.colors = gradientcolors
            layoutIfNeeded()
        }
    }
    
    var showType: ShowType = .normal(color: UIColor.white) {
        didSet {
            self.backgroundColor = nil
            self.gradientLayer.isHidden = true
            switch showType {
            case .normal(color: let backColor):
                self.backgroundColor = backColor
            case .gradient(colors: let colors):
                self.gradientLayer.isHidden = false
                self.gradientcolors = colors.map { $0.cgColor }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = self.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.addSublayer(gradientLayer)
//        if #available(iOS 11.0, *) {
//
//           // self.widthAnchor.constraint(equalToConstant: self.width).isActive = true
//          //  self.ts_touchInsets = UIEdgeInsets.init(top: -15, left: -15, bottom: -15, right: -15)
//
//        }else{
//            //增加按钮点击区域
//            self.ts_touchInsets = UIEdgeInsets.init(top: -15, left: -15, bottom: -15, right: -15)
//        }
//        self.ts_touchInsets = UIEdgeInsets.init(top: -20, left: -20, bottom: -20, right: -20)
        
        self.isExclusiveTouch = true
    }
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        if UIEdgeInsetsEqualToEdgeInsets(self.ts_touchInsets, .zero) || !self.isEnabled || self.isHidden {
//            return super.point(inside: point, with: event)
//        }
        let relativeFrame = self.bounds
        let widthDella: CGFloat = ( 44 - relativeFrame.size.width) > 0 ? ( 44 - relativeFrame.size.width) : 0
        let heightDella: CGFloat = ( 44 - relativeFrame.size.height) > 0 ? ( 44 - relativeFrame.size.height) : 0
        let frame = relativeFrame.insetBy(dx: -0.5 * widthDella, dy: -0.5 * heightDella)
        return frame.contains(point)
    }

    // MARK: - 构造方法
    required public init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.isExclusiveTouch = true
    }
    
}
