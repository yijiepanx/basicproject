//
//  VPAlamofireManager.swift
//  Vape
//
//  Created by Levin on 2018/1/8.
//  Copyright © 2018年 范国徽. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireManager: Alamofire.Session {
    
    static let sharedManager: AlamofireManager = {
                
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.httpShouldSetCookies = true
        configuration.httpCookieAcceptPolicy = .always
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy = .useProtocolCachePolicy
        let manager = AlamofireManager(configuration: configuration)
        return manager
    }()
    
}
