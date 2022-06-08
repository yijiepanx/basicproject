//
//  HUD+Helper.swift
//  FPVGreat
//
//  Created by youzu on 2020/11/13.
//

import UIKit

@objc
class HUDHelper: UIView {
    //自定义hud
//    @objc
//    static func showProgress(onView view: UIView?, message: String?){
//
//        DispatchQueue.main.async {
//            let window = view ?? UIApplication.applicationWindow!
//            MBProgressHUD.hide(for: window, animated: false)
//            let hud = MBProgressHUD.showAdded(to: view ?? window, animated: true)
//
//            hud.mode = MBProgressHUDMode.indeterminate;
//
//            hud.backgroundColor = UIColor.init(hexString: "#2F3039")
//            hud.label.text = message
//            hud.label.textColor = UIColor.white
//            hud.label.font = UIFont.boldSystemFont(ofSize: 13)
//            hud.backgroundView.style = .solidColor
//            hud.bezelView.style = .solidColor;
//            hud.backgroundView.backgroundColor = UIColor.clear
//            hud.bezelView.backgroundColor = UIColor.clear
////            hud.activityIndicatorColor = UIColor.white
////            if WOLUser.share.isReviewVersion {
////                hud.bezelView.backgroundColor = UIColor.white
////                hud.mode = MBProgressHUDMode.customView;
////                hud.bezelView.size = CGSize(width: 44, height: 44)
////                hud.customView = HUDHelper.customAnimationView()
////            }
//        }
//    }

// //自定义hud
//    static func showActivityProgress(onView view: UIView, isUserInteractionEnabled: Bool = false){
//        DispatchQueue.main.async {
//            let window = view
//            MBProgressHUD.hide(for: window, animated: false)
//            let hud = MBProgressHUD.showAdded(to: view , animated: true)
//            hud.mode = MBProgressHUDMode.indeterminate;
//            hud.backgroundColor = UIColor.clear
//            hud.bezelView.color = UIColor.clear
//            hud.bezelView.style = .blur
//            hud.backgroundView.style = .solidColor
//            hud.backgroundView.backgroundColor = UIColor.clear
////            hud.activityIndicatorColor = UIColor.white
//            hud.isUserInteractionEnabled = !isUserInteractionEnabled
//            hud.margin = 10;
//            hud.bezelView.style = .solidColor
//            hud.bezelView.backgroundColor = UIColor.clear
//        }
//    }

    //自定义hud
    static func showProgress(onView view: UIView?, _ isBottomView: Bool = true, isUserInteractionEnabled: Bool = false, isIndicator: Bool? = false){

        DispatchQueue.main.async {
            let window = view ?? UIApplication.applicationWindow!
            MBProgressHUD.hide(for: window, animated: false)
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
//            hud.mode = MBProgressHUDMode.indeterminate;
//            hud.backgroundColor = UIColor.clear
//            if isBottomView{
//                hud.bezelView.color = UIColor.black.withAlphaComponent(0.5)
//                hud.bezelView.size = CGSize(width: 30, height: 30)
//                hud.bezelView.layer.cornerRadius = 8.0
//                hud.bezelView.style = .blur
//            }else{
//                hud.bezelView.color = UIColor.clear
//                hud.bezelView.style = .solidColor
//            }
//            hud.bezelView.size = CGSize(width: 30, height: 30)
//            hud.bezelView.layer.cornerRadius = 8.0
//            hud.bezelView.backgroundColor = UIColor.white
//            hud.bezelView.backgroundColor = UIColor.init(hexString: "#000000").withAlphaComponent(0.64)
            hud.bezelView.style = .blur
//            hud.backgroundView.style = .solidColor
            hud.bezelView.blurEffectStyle = .dark
//            hud.backgroundView.backgroundColor = UIColor.clear
            hud.isUserInteractionEnabled = !isUserInteractionEnabled
//            hud.margin = 13;
//            if isIndicator == true {
//                hud.bezelView.style = .solidColor
//                hud.bezelView.backgroundColor = UIColor.clear
//            }
        }
    }

    //隐藏hud
    static func hideProgress(onView view: UIView? = nil){
        let window = view ?? UIApplication.applicationWindow!
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: window, animated: false)
        }
    }

    //展示信息  在上面
    static func showTopMessage(onView view: UIView, message:String){
        DispatchQueue.main.async {
            self.hideProgress(onView: view)
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = message
            hud.backgroundView.style = .solidColor
            hud.bezelView.style = .solidColor;
            hud.bezelView.backgroundColor = UIColor.init(hexString: "#000000").withAlphaComponent(0.64)
            hud.offset = CGPoint.init(x: 0, y: -(view.frame.size.height/3.0))
            hud.label.textColor = UIColor.white
            hud.margin = 13;
//            hud.offset = CGPoint.init(x: 0, y: CGFloat(60))
            hud.minSize = CGSize.init(width: 180, height: 45)
            hud.label.numberOfLines = 0
            hud.label.font = UIFont.systemFont(ofSize: 15)
            hud.isUserInteractionEnabled = false
            hud.hide(animated: true, afterDelay: 2)
        }
    }

    //展示信息  在中间
    static func showCenterMessage(onView view: UIView? = nil, message:String, duration: TimeInterval? = nil){
        let window = view ?? UIApplication.applicationWindow!
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: window, animated: false)
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = message
            hud.backgroundView.style = .solidColor
            hud.bezelView.style = .solidColor;
            hud.bezelView.blurEffectStyle = .dark
            hud.bezelView.backgroundColor = UIColor.init(hexString: "#000000").withAlphaComponent(0.64)
            hud.label.textColor = UIColor.white
            hud.margin = 13;
            hud.label.numberOfLines = 0
            hud.label.font = UIFont.systemFont(ofSize: 15)
            hud.minSize = CGSize.init(width: 180, height: 45)
            //hud.maxSize = CGSize.init(width: view.bounds.size.width * 2/3.0, height: view.bounds.size.height * 2/3.0)
//            hud.marginOffset = 60
            hud.isUserInteractionEnabled = false
            hud.hide(animated: true, afterDelay: duration ?? 3)
        }
    }

    //展示信息  在下面
    static func showBottomMessage(onView view: UIView? = nil, message:String?){
      
        DispatchQueue.main.async {
            guard !(message?.isEmpty ?? true) else {
                return
            }
            let window = view ?? UIApplication.applicationWindow!
            MBProgressHUD.hide(for: window, animated: false)
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = message
            hud.label.numberOfLines = 0;
            hud.label.font = UIFont.systemFont(ofSize: 14)
            hud.backgroundView.style = .solidColor
            hud.bezelView.style = .solidColor;
            hud.bezelView.backgroundColor = UIColor.init(hexString: "#2F3039")
            hud.offset = CGPoint.init(x: 0, y: window.frame.size.height/3.0)
            hud.label.textColor = UIColor.white
            hud.margin = 13;
            hud.offset = CGPoint.init(x: 0, y: CGFloat(window.height/2 - 60))
            hud.isUserInteractionEnabled = false
            hud.hide(animated: true, afterDelay: 2)
        }

    }


    //展示信息  在中间
    static func showSuccessMessage(onView view: UIView? = nil, message:String){
        guard !(message.isEmpty) else {
            return
        }
        let window = view ?? UIApplication.applicationWindow!

        DispatchQueue.main.async {
            MBProgressHUD.hide(for: window, animated: false)
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.mode = MBProgressHUDMode.customView
            hud.detailsLabel.text = message
            hud.backgroundView.style = .solidColor
            hud.bezelView.style = .solidColor;
            hud.bezelView.blurEffectStyle = .dark
            hud.bezelView.backgroundColor = UIColor.init(hexString: "#000000").withAlphaComponent(0.64)
            hud.detailsLabel.textColor = UIColor.white
            hud.detailsLabel.font = UIFont.systemFont(ofSize: 15)
            hud.detailsLabel.textColor = UIColor.white
            hud.contentColor = UIColor.white
            hud.margin = 13;
            hud.minSize = CGSize.init(width: 90, height: 90)
            hud.detailsLabel.numberOfLines = 0
            hud.offset = CGPoint.init(x: 0, y: CGFloat(60))
            let imageView: UIImageView = UIImageView.init(image: UIImage.init(named: "operate_successfully"))
            hud.customView = imageView
//            hud.maxSize = CGSize.init(width: 200, height: 1000)
            hud.removeFromSuperViewOnHide = true
            hud.isUserInteractionEnabled = false
            hud.hide(animated: true, afterDelay: 2)
        }
    }
    //展示信息  在中间
    static func showFailureMessage(onView view: UIView? = nil, message:String){
        let window = view ?? UIApplication.applicationWindow!
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: window, animated: false)
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.mode = MBProgressHUDMode.customView
            hud.detailsLabel.text = message
            hud.backgroundView.style = .solidColor
            hud.bezelView.style = .solidColor;
            hud.bezelView.blurEffectStyle = .dark
            hud.bezelView.backgroundColor = UIColor.init(hexString: "#000000").withAlphaComponent(0.64)
            hud.detailsLabel.textColor = UIColor.white
            hud.detailsLabel.font = UIFont.systemFont(ofSize: 15)
            hud.detailsLabel.textColor = UIColor.white
            hud.contentColor = UIColor.white
            hud.margin = 13;
            hud.minSize = CGSize.init(width: 90, height: 90)
            hud.detailsLabel.numberOfLines = 0
            hud.offset = CGPoint.init(x: 0, y: CGFloat(60))
            let imageView: UIImageView = UIImageView.init(image: UIImage.init(named: "fail_cross"))
            hud.customView = imageView
//            hud.maxSize = CGSize.init(width: 200, height: 1000)
            hud.removeFromSuperViewOnHide = true
            hud.isUserInteractionEnabled = false
            hud.hide(animated: true, afterDelay: 2)
        }
    }
//    //展示信息  在中间
//    static func showSorryMessage(onView view: UIView, message:String){
//        DispatchQueue.main.async {
//            MBProgressHUD.hideAllHUDs(for: view, animated: false)            let hud = MBProgressHUD.showAdded(to: view, animated: true)
//            hud.mode = MBProgressHUDMode.customView
//            hud.detailsLabel.text = message
//            hud.backgroundView.style = .solidColor
//            hud.bezelView.style = .solidColor;
//            hud.bezelView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
//            hud.detailsLabel.textColor = UIColor.white
//            hud.detailsLabel.font = VSMFont.regular(size: 13)
//            hud.detailsLabel.textColor = UIColor.white
//            hud.contentColor = UIColor.white
//            hud.margin = 10;
//            hud.marginVertical = 15;
//            hud.detailsLabel.numberOfLines = 0
//            hud.marginOffset = 50
//            hud.offset = CGPoint.init(x: 10, y: 10)
//            let imageView: UIImageView = UIImageView.init(image: UIImage.init(named: "holo_hud_sorry"))
//            hud.customView = imageView
//            hud.maxSize = CGSize.init(width: 220, height: 1000)
//
//            hud.isUserInteractionEnabled = false
//            hud.hide(animated: true, afterDelay: 2)
//        }
//    }
    //展示信息  在下面
//    static func showErrorMessage(onView view: UIView, error:RxSwiftMoyaError){
//        switch error {
//        case .RXSwiftMoyaNoNetwork:
//                HUDHelper.showBottomMessage(onView: view, message: VSMLanguageManager.Localized(key: "network_error_occurs_key"))
//            break
//        case .RxSwiftMoyaNotSuccessfulHTTP:
//               HUDHelper.showBottomMessage(onView: view, message:  VSMLanguageManager.Localized(key: "server_busy_Try_Later_key"))
//            break
//        case .RxSwiftMoyaBizError(resultCode: _, resultMsg: let msg):
//            if let message = msg, !VSMString.isVPEmpty(str: message)  {
//                HUDHelper.showBottomMessage(onView: view, message: message)
//            }
//            break
//        default:
//            HUDHelper.showBottomMessage(onView: view, message: VSMLanguageManager.Localized(key: "server_busy_Try_Later_key"))
//            break
//        }
//    }

    /// 网络或是服务器错误
    ///
    /// - Parameters:
    ///   - view: 要显示到的错误信息所在界面
    ///   - error: error错误详情 RxSwiftMoyaError
//    static func showFailMessage(onView view: UIView? = nil, error:RxSwiftMoyaError){
//        var window = UIApplication.shared.keyWindow as? UIView
//        if window == nil{
//            window = UIApplication.shared.delegate?.window as? UIView
//        }
//        switch error {
//        case .RXSwiftMoyaNoNetwork:
//            //  提示错误
//            HUDHelper.showBottomMessage(onView: view ?? window!, message: VSMLanguageManager.Localized(key: "network_error_occurs_key"))
//        case .RxSwiftMoyaNotSuccessfulHTTP:
//            //  提示错误
//            HUDHelper.showBottomMessage(onView: view ?? window!, message: VSMLanguageManager.Localized(key: "server_busy_Try_Later_key"))
//        default:
//            break
//        }
//    }

//    static func showCenterFailMessage(onView view: UIView? = nil, error:RxSwiftMoyaError){
//
//        let showView = view ?? (UIApplication.shared.keyWindow as! UIView)
//
//        switch error {
//        case .RXSwiftMoyaNoNetwork:
//            //  提示错误
////            HUDHelper.showTopMessage(onView: showView, message: VSMLanguageManager.Localized(key: "network_error_occurs_key"))
//            HUDHelper.showCenterMessage(onView: showView, message: VSMLanguageManager.Localized(key: "network_error_occurs_key"))
//        case .RxSwiftMoyaNotSuccessfulHTTP:
//            //  提示错误
////            HUDHelper.showTopMessage(onView: showView, message: VSMLanguageManager.Localized(key: "server_busy_Try_Later_key"))
//
//            HUDHelper.showCenterMessage(onView: showView, message: VSMLanguageManager.Localized(key: "server_busy_Try_Later_key"))
//
//        default:
//            break
//        }
//    }
}

//extension HUDHelper {
//
//    static func showMapSuccess(with tips: String) {
//        DispatchQueue.main.async {
//            HUD.allowsInteraction = true
//            HUD.flash(.customSuccess(image: UIImage(named: "holo_operate_successfully")!, title: tips), onView: nil, delay: 3, completion: nil)
//        }
//    }
//
//    static func showMapFail(with msg: String){
//        DispatchQueue.main.async {
//            HUD.allowsInteraction = true
//            HUD.flash((.customLabel(text: msg)), delay: 3)
//       }
//    }
//}

