//
//  ButtonExtension.swift
//  SalonPro
//
//  Created by 潘艺杰 on 2020/8/27.
//  Copyright © 2020 pyj. All rights reserved.
//

import UIKit

// MARK: -  扩展方法（类，对象）

enum XPButtonLayoutStyle {
    case top //基于image位置的枚举
    case left
    case bottom
    case right
}
// MARK: -  button扩展枚举调节图片文字位置
extension UIButton {
    /**
     ## 使用该方法button必须设置title和image
     ## 不宜使用snpkit或者masonry等约束布局方式，因为添加gap后，button的原尺寸无法修改
     ## 如果使用约束布局，需要在约束执行后调用本方法
     */
    func xpLayoutButtonEdgeInsetStyle(style : XPButtonLayoutStyle , imageTitleGap : CGFloat) {
        /**
        *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
        *  如果只有title，那它上下左右都是相对于button的，image也是一样；
        *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
        */
//        let imageW : CGFloat? = self.imageView?.frame.size.width
//        let imageH : CGFloat? = self.imageView?.frame.size.height
        
        let imageW : CGFloat? = self.imageView?.intrinsicContentSize.width
        let imageH : CGFloat? = self.imageView?.intrinsicContentSize.height
        
        var labelW : CGFloat? = 0.0
        var labelH : CGFloat? = 0.0
        
        if  ((UIDevice.current.systemVersion) as NSString).floatValue >= 8 {
            labelW = self.titleLabel?.intrinsicContentSize.width
            labelH = self.titleLabel?.intrinsicContentSize.height
        } else {
            labelW = self.titleLabel?.frame.width
            labelH = self.titleLabel?.frame.height
        }
        
        var imageEdInsets = UIEdgeInsets.zero
        var labelEdInsets = UIEdgeInsets.zero
        
        switch style {
        case .top:
            imageEdInsets = UIEdgeInsets(top: -labelH! - imageTitleGap / 2, left: 0, bottom: 0, right: -labelW!)
            labelEdInsets = UIEdgeInsets(top: 0, left: -imageW!, bottom: -imageH! - imageTitleGap / 2.0, right: 0)
        case .left:
            imageEdInsets = UIEdgeInsets(top: 0, left: -imageTitleGap / 2, bottom: 0, right: imageTitleGap / 2)
            labelEdInsets = UIEdgeInsets(top: 0, left: imageTitleGap / 2, bottom: 0, right: -imageTitleGap / 2)
        case .bottom:
            imageEdInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelH! - imageTitleGap / 2.0, right: -labelW!)
            labelEdInsets = UIEdgeInsets(top: -imageH! - imageTitleGap / 2.0, left: -imageW!, bottom: 0, right: 0)
        case .right:
            imageEdInsets = UIEdgeInsets(top: 0, left: labelW! + imageTitleGap / 2.0, bottom: 0, right: -labelW! - imageTitleGap / 2.0)
            labelEdInsets = UIEdgeInsets(top: 0, left: -imageW! - imageTitleGap / 2.0, bottom: 0, right: imageH! + imageTitleGap / 2.0)
        }
        
        self.titleEdgeInsets = labelEdInsets
        self.imageEdgeInsets = imageEdInsets
        
        //无法重置button的约束宽度
//        self.frame.size.width = labelW! + imageW! + imageTitleGap
        
    }
    
    
    
    //验证码倒计时
    func countDown(timeOut: Int, normalColor: UIColor, disabledColor: UIColor){
            
            //倒计时时间
            var timeout = timeOut
            let queue:DispatchQueue = DispatchQueue.global(qos: .default)
            
            // 在global线程里创建一个时间源
            let codeTimer = DispatchSource.makeTimerSource(queue:queue)
            
            codeTimer.schedule(deadline: .now(), repeating:.seconds(1))

            //每秒执行
            codeTimer.setEventHandler(handler: { () -> Void in
                if(timeout<=0){ //倒计时结束，关闭
                    codeTimer.cancel()
                    
                    DispatchQueue.main.sync(execute: { () -> Void in
                        //设置界面的按钮显示 根据自己需求设置
//                         self.backgroundColor = normalColor
                        self.setTitle("获取验证码", for: .normal)
                       
                        self.isUserInteractionEnabled = true
                        
                        
                    })
                }else{//正在倒计时
                    
                    let seconds = timeout
                    let strTime = NSString.localizedStringWithFormat("%.d", seconds)
                    
                    DispatchQueue.main.sync(execute: { () -> Void in
                        //                    NSLog("----%@", NSString.localizedStringWithFormat("%@S", strTime) as String)
                        
                        UIView.animate(withDuration: 1) {
                            self.setTitle(NSString.localizedStringWithFormat("%@s", strTime) as String, for: .normal)
                        }
                        self.isUserInteractionEnabled = false
                    })
                    timeout -= 1;
                }
                
            })
            codeTimer.resume()
        }

    
            
}
