//
//  OKHomeApi.swift
//  okart
//
//  Created by panyijie on 2022/5/18.
//

import UIKit
import Moya
import RxSwift
import HandyJSON

let OKHomeApiProvider = MoyaProvider<OKHomeApi>(session: AlamofireManager.sharedManager, plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])

public enum OKHomeApi{
    ///Banner
    case homeBannerList
    ///首页主题列表
    case homeThemeList(page : Int)
    ///主题详情
    case themeDetail(id : Int)
    ///首页最新列表  清单类型 1:发售中 2:待发售 0:全部(1+2)。默认值为0
    case homeTimelineList(page : Int,type : Int = 0)
    ///卖品详情
    case goodsDetail(id : String)
    
    
}

extension OKHomeApi: CustomTargetType {
    var pageSize:Int{
        return 10
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .homeThemeList(page: let page):
            var parameter: [String: Any] = [:]
            parameter["page"] = page
            parameter["limit"] = pageSize
            parameter["ga"] = RequestCombina.exportgastring(with:path)
            return parameter
        case .themeDetail(id : let id):
            var parameter: [String: Any] = [:]
            parameter["id"] = id
            parameter["token"] = SSaiLoginUser.share.token
            parameter["ga"] = RequestCombina.exportgastring(with:path)
            return parameter
        case .homeTimelineList(page: let page,type: let type):
            var parameter: [String: Any] = [:]
            parameter["page"] = page
            parameter["limit"] = pageSize
            parameter["type"] = type
            parameter["ga"] = RequestCombina.exportgastring(with:path)
            return parameter
        case .homeBannerList:
            var parameter: [String: Any] = [:]
            parameter["device"] = 3
            parameter["ga"] = RequestCombina.exportgastring(with:path)
            return parameter
        case .goodsDetail(id: let id):
            var parameter: [String: Any] = [:]
            parameter["itemid"] = id
            parameter["token"] = SSaiLoginUser.share.token
            parameter["ga"] = RequestCombina.exportgastring(with:path)
            return parameter
        }
    }
        
    public var path: String {
        switch self {
        case .homeThemeList:
            return "listseries"
        case .themeDetail:
            return "seriesdetail"
        case .homeTimelineList:
            return "listonsale"
        case .homeBannerList:
            return "listbanner"
        case .goodsDetail:
            return "itemdetail"
        }
        
    }
    
    
    
    
}

