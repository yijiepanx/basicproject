//
//  OKLoginApi.swift
//  okart
//
//  Created by panyijie on 2022/5/19.
//

import UIKit
import Moya
import RxSwift
import HandyJSON

let OKLoginApiProvider = MoyaProvider<OKLoginApi>(session: AlamofireManager.sharedManager, plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])

public enum OKLoginApi{
    ///登录-minip
    case login(code : String,nickname : String? = nil,avatar : String? = nil,debugnumber : String? = nil)
    ///登录-app
    case smslogin(mobile : String,vcode : String)
    
    
    
    
}

extension OKLoginApi: CustomTargetType {
    var pageSize:Int{
        return 10
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .login(code: let code, nickname: let nickname, avatar: let avatar, debugnumber: let debugnumber):
            var parameter: [String: Any] = [:]
            parameter["code"] = code
            parameter["nickname"] = nickname
            parameter["avatar"] = avatar
            parameter["debugnumber"] = debugnumber
            if let tnick = nickname {
            }
            parameter["ga"] = RequestCombina.exportgastring(with:path)
            return parameter
        case .smslogin(mobile: let mobile, vcode: let vcode):
            var parameter: [String: Any] = [:]
            parameter["mobile"] = mobile
            parameter["vcode"] = vcode
            parameter["ga"] = RequestCombina.exportgastring(with:path)
            return parameter
        }
    }
        
    public var path: String {
        switch self {
        case .login:
            return "wechatlogin"
        case .smslogin:
            return "smslogin"
        }
        
    }
    
    
    
    
}


