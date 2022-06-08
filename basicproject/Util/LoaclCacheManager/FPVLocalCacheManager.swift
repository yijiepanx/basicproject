//
//  FPVLocalCacheManager.swift
//  SalonPro
//
//  Created by 潘艺杰 on 2020/9/7.
//  Copyright © 2020 pyj. All rights reserved.
//

import UIKit

class FPVLocalCacheManager: NSObject {

    static let share = FPVLocalCacheManager()

    let userDefaults = UserDefaults.standard
    
    
}
// MARK: -  //登录信息
extension FPVLocalCacheManager {
    func setLoginStatus(isLogin : Bool) {
        userDefaults.set(isLogin, forKey: "salonUserLoginStatus")
    }
    func isLogin() -> Bool {
        guard let islogin = userDefaults.object(forKey: "salonUserLoginStatus") as? Bool else { return false }
        return islogin
    }
    
    func setUserId(userId : String) {
        userDefaults.set(userId, forKey: "salonUserInfoId")
    }
    func getUserId() -> String {
        guard let userId = userDefaults.object(forKey: "salonUserInfoId") as? String else { return "" }
        return userId
    }
    //用户手艺人ID
    func setUserCraftId(craftId : String) {
        userDefaults.set(craftId, forKey: "setUserCraftId")
    }
    func getUserCraftId() -> String {
        guard let craftId = userDefaults.object(forKey: "setUserCraftId") as? String else { return "" }
        return craftId
    }
    //用户店铺ID
    func setUserStoreId(userStoreId : String) {
        userDefaults.set(userStoreId, forKey: "setUserStoreId")
    }
    func getUserStoreId() -> String {
        guard let userStoreId = userDefaults.object(forKey: "setUserStoreId") as? String else { return "" }
        return userStoreId
    }
    func setUserStoreName(userStoreName : String) {
        userDefaults.set(userStoreName, forKey: "setUserStoreName")
    }
    func getUserStoreName() -> String {
        guard let userStoreName = userDefaults.object(forKey: "setUserStoreName") as? String else { return "" }
        return userStoreName
    }
    
    func setUserToken(userId : String) {
        userDefaults.set(userId, forKey: "setUserToken")
    }
    func getUserToken() -> String {
        guard let userId = userDefaults.object(forKey: "setUserToken") as? String else { return "" }
        return userId
    }
    
    func setUserPhone(phone : String) {
        userDefaults.set(phone, forKey: "salonUserPhone")
    }
    func getUserPhone() -> String {
        guard let UserPhone = userDefaults.object(forKey: "salonUserPhone") as? String else { return "" }
        return UserPhone
    }
    
    func setUserAvatar(str : String) {
        userDefaults.set(str, forKey: "setUserAvatar")
    }
    func getUserAvatar() -> String {
        guard let str = userDefaults.object(forKey: "setUserAvatar") as? String else { return "" }
        return str
    }
    
    func setUserName(str : String) {
        userDefaults.set(str, forKey: "setUserName")
    }
    func getUserName() -> String {
        guard let str = userDefaults.object(forKey: "setUserName") as? String else { return "" }
        return str
    }
    
    func setUserInviteCode(str : String) {
        userDefaults.set(str, forKey: "InviteCode")
    }
    func getInviteCode() -> String {
        guard let str = userDefaults.object(forKey: "InviteCode") as? String else { return "" }
        return str
    }
    
    func setUserLevel(str : String) {
        userDefaults.set(str, forKey: "setUserLevel")
    }
    func getUserLevel() -> String {
        guard let str = userDefaults.object(forKey: "setUserLevel") as? String else { return "" }
        return str
    }
        
    //本地地理位置
    func setLocationLat(str : String) {
        userDefaults.set(str, forKey: "setLocationLat")
    }
    func getLocationLat() -> String {
        guard let str = userDefaults.object(forKey: "setLocationLat") as? String else { return "" }
        return str
    }
    func setLocationLng(str : String) {
        userDefaults.set(str, forKey: "setLocationLng")
    }
    func getLocationLng() -> String {
        guard let str = userDefaults.object(forKey: "setLocationLng") as? String else { return "" }
        return str
    }
    
    
}


// MARK: -  //页面存储信息
extension FPVLocalCacheManager {

    func setHomeSearchHistory(array : [String]) {
        userDefaults.set(array, forKey: "HomeSearchHistory")
    }
    func getHomeSearchHistory() -> [String] {
        guard let array = userDefaults.object(forKey: "HomeSearchHistory") as? [String] else { return [] }
        return array
    }
    
    
    // MARK: -  省市区模块缓存数据 [[String : Any]]
    func setCustomAreaDataCache(array : Data) {
        userDefaults.set(array, forKey: "setCustomAreaDataCache")
    }
    func getCustomAreaDataCache() -> Data? {
        guard let array = userDefaults.object(forKey: "setCustomAreaDataCache") as? Data else { return nil }
        return array
    }

}
