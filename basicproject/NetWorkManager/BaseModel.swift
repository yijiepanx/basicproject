//
//  BaseListModel.swift
//  Vape
//
//  Created by Levin on 2017/3/29.
//  Copyright © 2017年 范国徽. All rights reserved.
//

import UIKit
import HandyJSON

enum RxSwiftMoyaError: Error {
    case RxSwiftMoyaNoRepresentor
    case RxSwiftMoyaNotSuccessfulHTTP
    case RxSwiftMoyaNoData
    case RxSwiftMoyaCouldNotMakeObjectError
    case RxSwiftMoyaBizError(resultCode: Int?, resultMsg: String?)
    case RxSwiftMoyaBizBaseModelError(resultCode: Int?, response: String?)
    case RXSwiftMoyaNoNetwork
}

struct ErrorCode {
    static let successCode = 1
    static let reloginCode = -1  //登录失效
    
    static let tokenInvalidate = 888 //token失效
    

}



/**
 okart 接口返回Model 校验code用
 */

public class OKArtBaseModel : HandyJSON {
    var rst : Int = 0
    var msg : String?
    
    var success: Bool {
        
        if rst <= 0 {
//            if rst == ErrorCode.reloginCode {
//                if SSaiLoginManager.isUserLogin {
//                    SSaiLoginUser.share.loginOutAction()
//                }
//            }
            return false
        }
        return true
        
    }
    
    required public init() {}
}


/**
 用于场馆订单校验model ，自定义判断库存等操作
 */
public class VerifyBaseModel<T: HandyJSON>: HandyJSON {
    
    var code: Int?
        
    var tips: String?
    
    var msg: String?
    
    var tm: Int?
    
    var data: T?
    
    var success: Bool {
        if code == ErrorCode.reloginCode || code == ErrorCode.tokenInvalidate {
//            if SSaiLoginManager.isUserLogin {
//                SSaiLoginUser.share.loginOutAction()
//            }else{
////                LoginService().checkLoginAndShowLoginVC(finish: nil)
//            }
            return false
        }
        return true
    }
    
    var jsonStr: String?
    var cacheKey: String?
    required public init() {}
    
    public func didFinishMapping() {
//        print("BaseModel_")
    }
    
    
    
}


public class BaseModel<T: HandyJSON>: HandyJSON {
    
    
    var code: Int?
        
    var tips: String?
    
    var msg: String?
    
    var tm: Int?
    
    var data: T?
    
    var success: Bool {
        if code == ErrorCode.reloginCode || code == ErrorCode.tokenInvalidate {
//            if SSaiLoginManager.isUserLogin {
//                SSaiLoginUser.share.loginOutAction()
//            }else{
////                LoginService().checkLoginAndShowLoginVC(finish: nil)
//            }
            return false
        }
        guard let co = code, co == ErrorCode.successCode else {
            return false
        }
        return true
    }
    
    var jsonStr: String?
    var cacheKey: String?
    required public init() {}
    
    public func didFinishMapping() {
//        print("BaseModel_")
    }
    
    
    
}
class AnyModel: HandyJSON {
        
    required init() {}
}


public class BaseModelOnly: HandyJSON {

    var code: Int?

    var msg: String?

    var tips: String?

    var data: NSDictionary?
    
    var success: Bool {
        if code == ErrorCode.reloginCode || code == ErrorCode.tokenInvalidate {
//            SSaiLoginUser.share.loginOutAction()
            return false
        }
        guard let co = code, co == ErrorCode.successCode else {
            return false
        }
        return true
    }

    required public init() {}

}


public class ArrayModel<T: HandyJSON>: HandyJSON {
    
    var code: Int?
    
    var msg: String?
    
    var tips: String?
    
    var data: [T]?
    
    var success: Bool {
        if code == ErrorCode.reloginCode || code == ErrorCode.tokenInvalidate {
//            if SSaiLoginManager.isUserLogin {
//                SSaiLoginUser.share.loginOutAction()
//            }else{
////                LoginService().checkLoginAndShowLoginVC(finish: nil)
//            }
            return false
        }
        guard let co = code, co == ErrorCode.successCode else {
            return false
        }
        return true
    }
    
    required public init() {}
    
}

public class StringListModel: HandyJSON {
    required public init() {}
    var list: [String] = []
}






