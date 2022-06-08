//
//  VPTargetType.swift
//  Vape
//
//  Created by Shawn on 2019/4/29.
//  Copyright © 2019 ChenJianglin. All rights reserved.
//

import Foundation
import Moya

struct requestConfig{
//    static let requestPath: String = "http://fpv-app-qa.youzu.com/api/v1"
    
//    static let requestPath: String = "https://nft.okart.vip/Api/"  //test

    static let requestPath: String = "https://nft.okart.vip/Api/"   //prd
    
    static let webPath: String = "https://nft.okart.vip/Api/"
}

public protocol CustomTargetType: TargetType{
    
    var parameters: [String: Any]?{ get }
    
}

public extension CustomTargetType {
    
    var baseURL: URL {
        return URL(string: requestConfig.requestPath)!
    }
    
    var headers: [String: String]? {
        return RequestCombina.configRequestRequestHeader(path: self.path)
    }
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
//        print(self.parameters)
        switch method {
        case .get:
            return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: parameters ?? [:], encoding: JSONEncoding.default)
        }
    }
    
    var sampleData: Data {
        return "{\"code\"ok\",\"data\": {}}".data(using: .utf8)!
    }
    
}
