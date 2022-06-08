//
//  SSaiLoginUser.swift
//  FPVGreat
//
//  Created by youzu on 2020/11/13.
//

import UIKit
import HandyJSON



class SSaiLoginUser: HandyJSON,DefaultsSerializable, Codable{
    
    var uid : String?
    var token: String?
    var nickname: String?
    var avatar: String?
    var address: String?
    var mobile: String?
    var verified : Bool = false
    
    
    required init() { }
        
    static let share = SSaiLoginUser()
    
    
    func refreshLoginUser(user: SSaiLoginUser) {
        self.uid = user.uid
        self.avatar = user.avatar
        self.token = user.token
        self.nickname = user.nickname
        self.address = user.address
        self.mobile = user.mobile
        self.verified = user.verified
    }
    
    //用户退出登录状态的时候操作
    func loginOutAction() {
        self.token = nil
        
        let loginManager = SSaiLoginManager()
        loginManager.refreshAndCache(for: self)
        
        //判断上个用户是否有未上传的receipt
        //        if let useId = SSaiLoginUser.share.user_id {
        //            IAPManager.share.uploadReceiptComplete(userId: useId)
        //        }
        
    }
    
}



import SwiftyUserDefaults

struct SSaiLoginManager {
    
    let cachekey: String = "login_user_cache"
        
    static var isUserLogin: Bool {
        return !(SSaiLoginUser.share.token?.isEmptyStr ?? true)
    }
    
    //最多保留5条
    var maxNumber: Int = 5
    //获取所有的历史记录
    func localLoginUser() -> SSaiLoginUser? {
        let userKeyStr = cachekey
        let defaultHistoryKey = DefaultsKey<SSaiLoginUser?>(userKeyStr)
        let localLoginUser = Defaults[key: defaultHistoryKey]
        return localLoginUser
    }
    
    func refreshAndCache(for user: SSaiLoginUser?) {
        guard let loginUser = user else {
            return
        }
        //刷新当前单利的登录数据
        SSaiLoginUser.share.refreshLoginUser(user: loginUser)
        let userKeyStr = cachekey
        let defaultHistoryKey = DefaultsKey<SSaiLoginUser?>(userKeyStr)
        Defaults[key: defaultHistoryKey] = loginUser
        let user = Defaults[key: defaultHistoryKey]
        print(user as Any)
    }
    
    func clearLocalCache() {
        let userKeyStr = cachekey
        let localUserKey = DefaultsKey<SSaiLoginUser?>(userKeyStr)
        Defaults[key: localUserKey] = nil
    }
    
    
}

extension SSaiLoginManager {
//    //用户退出的时候，清空token, 不清楚用户信息
//    func loginOutAction(){
//        let localUser = SSaiLoginUser.share
//        localUser.token = nil
//        refreshAndCache(for: localUser)
//    }
    
    static func loginUserSameTo(user_id: String?) -> Bool{
        guard let uid = user_id else {
            return false
        }
        guard SSaiLoginManager.isUserLogin, SSaiLoginUser.share.uid?.isEqualTo(str: uid) ?? false else {
            return false
        }
        return true
    }
}

