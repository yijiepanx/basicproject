//
//  VPRequestApi.swift
//  Vape
//
//  Created by Chenjianglin on 2018/2/6.
//  Copyright © 2018年 ChenJianglin. All rights reserved.
//

import UIKit
import Moya
import HandyJSON
import Alamofire
import CryptoSwift

class RequestCombina: NSObject {
    
    struct RequestInfo {
        
        static let appid: String  = "5EewXD1i"
        
        static let appSecret: String = "RfhHecN9zsNcy19Y"
    }
    
    static let share: RequestCombina = RequestCombina()
    static func configRequestRequestHeader(path: String) -> [String: String]{
        
//        let timeStamp = Date().seconds
//
//        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
//        let secret =  ""
//        var parms = ["AppId": RequestInfo.appid, "Timestamp": timeStamp, "Version": version, "Secret": secret]
//
//        if SSaiLoginManager.isUserLogin {
//            let token = SSaiLoginUser.share.token ?? ""
//            parms["auth"] = token
//        }else{
//            parms["auth"] = ""
//        }
//
//        //secret 是初始化接口下发的
//        var component = "/api/v1" + path + "&AppId=\(String(describing: parms["AppId"] ?? ""))&Timestamp=\(String(describing: parms["Timestamp"] ?? ""))&Version=\(String(describing: parms["Version"] ?? ""))"
//        if path.isEqualTo(str: "/client/init") == false {
//            if !secret.isEmptyStr {
//                component += "&Secret=\(String(describing: parms["Secret"] ?? ""))"
//            }
//        }
//        component += "&\(RequestInfo.appSecret)"
////        print("component ----\(component)")
//        let token = component.md5().lowercased()
////        print("component---\(component) token ---- \(token)")
//        parms["Sign"] = token
//        print(parms)
        return [:]
    }
    
    static func dictToSortString(paramter: [String: Any]?) -> String{
        var commonParameter: [String: Any] = [:]
        //将接口参数添加到字典中
        if let paramter = paramter {
            for (key, value) in paramter {
                commonParameter[key] = value
            }
        }
        //将字典拼接成字符串类似 key=value&key=value
        var components: [(String, Any)] = []
        let sorted = commonParameter.sorted(by: {$0.key < $1.key})
        for (key, value) in sorted {
            components.append((key,value))
        }
        let component = components.map { "\($0)=\($1)" }.joined(separator: "&")
        return component
    }
    
    
    
    /**
     ********
     */
    static func exportgastring(with inkey : String) -> String {
        let randomArr : [Character] = ["A","B","C","D","E","F","G","H","I","J"]
        
//        print(inkey)
        var outkey = ""
        
        let timeFullString : String = "\(Int(NSDate().timeIntervalSince1970))"
//        print(timeFullString)
        
        let prefixTimeFour = (timeFullString as NSString).substring(with: NSRange(location: 0, length: 4))
        let suffixTimeFour = (timeFullString as NSString).substring(with: NSRange(location: timeFullString.count - 4, length: 4))
//        print(prefixTimeFour)
//        print(suffixTimeFour)
        
        let combinaString = prefixTimeFour + inkey + suffixTimeFour
//        print(combinaString)
        
        let mdString = combinaString.md5().uppercased()
//        print(mdString)
        
        var mdCharArr = [Character]()
        for tchar in mdString {
            mdCharArr.append(tchar)
        }
//        print(mdCharArr)
        for i in 0...mdCharArr.count - 1 {
            if i % 2 == 0 {
                let c1 = mdCharArr[i]
                mdCharArr[i] = mdCharArr[i + 1]
                mdCharArr[i + 1] = c1
            }
        }
//        print(mdCharArr)
        
        func doublerandomchangecheck() {
            let exchar = mdCharArr[Int.random(in: 0..<mdCharArr.count)]
            var chchar = Character("\(Int.random(in: 0..<10))")
            while exchar == chchar {
                chchar = Character("\(Int.random(in: 0..<10))")
            }
            mdCharArr[Int.random(in: 0..<mdCharArr.count)] = chchar
        }
        doublerandomchangecheck()
//        print(mdCharArr)
        
        var mdcharString = ""
        for tchar in mdCharArr {
            mdcharString.append(tchar)
        }
//        print(mdcharString)
        
        
        let cuttimeString = (timeFullString as NSString).replacingCharacters(in: NSRange(location: 0, length: 4), with: "")
//        print(cuttimeString)
        var cuttimeArr = [Character]()
        for tchar in cuttimeString {
            cuttimeArr.append(tchar)
        }
//        print(cuttimeArr)
        cuttimeArr = cuttimeArr.reversed()
//        print(cuttimeArr)
        for i in 0...cuttimeArr.count - 1 {
            let index = Int(String(cuttimeArr[i]))
            cuttimeArr[i] = randomArr[index ?? 0]
        }
//        print(cuttimeArr)
        
        var cutcharString = ""
        for tchar in cuttimeArr {
            cutcharString.append(tchar)
        }
//        print(cutcharString)
        
        outkey = cutcharString + mdcharString
//        print(outkey)
        
        return outkey
    }
    
    
//    static func getDeviceTimeZone() -> String{
//        let abbreviation = TimeZone.current.abbreviation()?.replacingOccurrences(of: "GMT", with: "")
//        let timeZone = TimeZone.currentZoneStr
//        /// TimeZone(identifier: TimeZone.knownTimeZoneIdentifiers[231])?.abbreviation()
//        /// Asia/Calcutta --> GMT+5:30
//        var fixTimeZone = timeZone
//        if timeZone.contains(":") {
//            let array = timeZone.components(separatedBy: ":")
//            if array.count == 2,
//                let first = array.first,
//                let f = Float(first),
//                let second = array.last,
//                let s = Float(second) {
//                let fix = abs(f) + Float(s / 60)
//
//                if f >= 0 {
//                    fixTimeZone = "+\(fix)"
//                } else {
//                    fixTimeZone = "-\(fix)"
//                }
//            }
//        }
//        return fixTimeZone
//    }
    
    
}


extension NSObject {
    
    /// 判断网络
    ///
    /// - Returns: 返回网络状态
    func checkInternet() -> Bool{
        if let isReachable = NetworkReachabilityManager()?.isReachable {
            return isReachable
        }
        return false
    }
    
    /// 判断网络并且提示
    ///
    /// - Returns: 返回网络状态
    /// 判断网络并且提示
    ///
    /// - Returns: 返回网络状态
    func checkInternetTips(view: UIView? = nil, showError: Bool = true, finish: (() -> ())? = nil){
        if checkInternet() {
            finish?()
            return
        }
        guard showError else {
            return
        }
        HUDHelper.showCenterMessage(message: "网络异常，请检查网络~")
    }

    
    //当网络正常的时候开始处理事件
    func checkNetworkHandler(showError: Bool = true, finish: (() -> ())? = nil){
        checkInternetTips(showError: showError, finish: {
            finish?()
        })
    }
    

}
