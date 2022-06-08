//
//  VPRequestTool.swift
//  Vape
//
//  Created by Levin on 2017/3/22.
//  Copyright © 2017年 范国徽. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON
import Alamofire
import SwiftyUserDefaults

extension ObservableType where Element == Response {
    
    //okart 接口解析
    public func mapSingleModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            let ele : T = try response.mapSingleBaseModel(type)
            return Observable.just(ele)
        }
    }
    
    
    //解析订单校验model，自判断code错误
    public func mapVerifyBaseModel<T: HandyJSON>(_ type: T.Type, _ needNoDataErr: Bool? = true, _ needHudTip: Bool? = true) -> Observable<VerifyBaseModel<T>> {
        return flatMap { response -> Observable<VerifyBaseModel<T>> in
            
            let ele: VerifyBaseModel<T> = try response.mapVerifyBaseModel(T.self, needNoDataErr, needHudTip)
            return Observable.just(ele)
        }
    }
    
    public func mapBaseModel<T: HandyJSON>(_ type: T.Type, _ needNoDataErr: Bool? = true, _ needHudTip: Bool? = true) -> Observable<BaseModel<T>> {
        return flatMap { response -> Observable<BaseModel<T>> in
            
            let ele: BaseModel<T> = try response.mapBaseModel(T.self, needNoDataErr, needHudTip)
            return Observable.just(ele)
        }
    }
    
    public func mapBaseModelArray<T: HandyJSON>(_ type: T.Type,_ needNoDataErr: Bool? = true, _ needHudTip: Bool? = true ) -> Observable<BaseModel<BaseListModel<T>>> {
        
        return flatMap { response -> Observable<BaseModel<BaseListModel<T>>> in
            return Observable.just(try response.mapBaseModelArray(T.self,needHudTip,needNoDataErr))
        }
    }
    
}
private struct AssociatedKeys {
    static var cacheKey = "vfamily-cache-key"
}
extension Response {
    var cacheKey: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.cacheKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.cacheKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func mapSingleBaseModel<T : HandyJSON>(_ type: T.Type, _ needNoDataErr: Bool? = true, _ needHudTip: Bool? = true) throws -> T {
        // check http status
        guard -1001 != self.statusCode else {
            throw RxSwiftMoyaError.RXSwiftMoyaNoNetwork
        }
        
        let jsonString = String.init(data: data, encoding: .utf8)
        
        let verifyModel = JSONDeserializer<OKArtBaseModel>.deserializeFrom(json: jsonString)
        guard let vmodel = verifyModel else {
            throw RxSwiftMoyaError.RxSwiftMoyaCouldNotMakeObjectError
        }
        
        guard vmodel.success else{
            throw RxSwiftMoyaError.RxSwiftMoyaBizError(resultCode:vmodel.rst,resultMsg:vmodel.msg)
        }
        
        let baseModel = JSONDeserializer<T>.deserializeFrom(json: jsonString)
        guard let bmodel = baseModel else {
            throw RxSwiftMoyaError.RxSwiftMoyaCouldNotMakeObjectError
        }
        
                        
        return bmodel
    }
    
 
    //解析订单校验model，自判断code错误
    func mapVerifyBaseModel<T: HandyJSON>(_ type: T.Type, _ needNoDataErr: Bool? = true, _ needHudTip: Bool? = true) throws -> VerifyBaseModel<T> {
        
        // check http status
        guard -1001 != self.statusCode else {
            throw RxSwiftMoyaError.RXSwiftMoyaNoNetwork
        }
        /**
         增加401网络判断 token失效  需优化
         */
//        if let _ = self.response {
//            guard ((200...209) ~= self.statusCode || self.statusCode == 401) else {
//                throw RxSwiftMoyaError.RxSwiftMoyaNotSuccessfulHTTP
//            }
//        }
        
        let jsonString = String.init(data: data, encoding: .utf8)
        
        let baseModel = JSONDeserializer<VerifyBaseModel<T>>.deserializeFrom(json: jsonString)
        
        
        guard let model = baseModel else {
            
            throw RxSwiftMoyaError.RxSwiftMoyaCouldNotMakeObjectError
        }
                
        guard model.success else{
            
            throw RxSwiftMoyaError.RxSwiftMoyaBizError(resultCode:model.code,resultMsg:model.msg)
        }
        
        if needNoDataErr == true {
            guard (model.data != nil)  else {
                throw RxSwiftMoyaError.RxSwiftMoyaNoData
            }
        }
        
        model.jsonStr = jsonString
        model.cacheKey = self.cacheKey
        return model
    }
    
    
    func mapBaseModel<T: HandyJSON>(_ type: T.Type, _ needNoDataErr: Bool? = true, _ needHudTip: Bool? = true) throws -> BaseModel<T> {
        
        // check http status
        guard -1001 != self.statusCode else {
            throw RxSwiftMoyaError.RXSwiftMoyaNoNetwork
        }
        /**
         增加401网络判断 token失效  需优化
         */
        if let _ = self.response {
            guard ((200...209) ~= self.statusCode || self.statusCode == 401) else {
                throw RxSwiftMoyaError.RxSwiftMoyaNotSuccessfulHTTP
            }
        }
        
        let jsonString = String.init(data: data, encoding: .utf8)
        
        let baseModel = JSONDeserializer<BaseModel<T>>.deserializeFrom(json: jsonString)
        
        
        guard let model = baseModel else {
            
            throw RxSwiftMoyaError.RxSwiftMoyaCouldNotMakeObjectError
        }
                
        guard model.success else{
            
            throw RxSwiftMoyaError.RxSwiftMoyaBizError(resultCode:model.code,resultMsg:model.msg)
        }
        
        if needNoDataErr == true {
            guard (model.data != nil)  else {
                throw RxSwiftMoyaError.RxSwiftMoyaNoData
            }
        }
        
        model.jsonStr = jsonString
        model.cacheKey = self.cacheKey
        return model
    }
    
    
    
    func mapBaseModelArray<T: HandyJSON>(_ type: T.Type,_ needHudTip: Bool? = true ,_ needNoDataErr: Bool? = true ) throws -> BaseModel<BaseListModel<T>>  {
        // check http status
        guard -1001 != self.statusCode else {
            throw RxSwiftMoyaError.RXSwiftMoyaNoNetwork
        }
        
        if let _ = self.response {
            guard ((200...209) ~= self.statusCode || self.statusCode == 401) else {
                throw RxSwiftMoyaError.RxSwiftMoyaNotSuccessfulHTTP
            }
        }
        
        let jsonString = String.init(data: data, encoding: .utf8)

        guard let baseModel =  JSONDeserializer<BaseModel<BaseListModel<T>>>.deserializeFrom(json: jsonString) else {
            
            throw RxSwiftMoyaError.RxSwiftMoyaCouldNotMakeObjectError
        }
        
        guard baseModel.success else{
            
            throw RxSwiftMoyaError.RxSwiftMoyaBizError(resultCode:baseModel.code,resultMsg:baseModel.msg)
        }
        
        baseModel.jsonStr = jsonString
        return baseModel
    }
    
}

extension MoyaProvider {
    
    
    /// 先判断有没有网络 新版网络请求 needCache 本次结果是否需要缓存， isCache 本次结果是否要获取缓存
    func tryUserIsOffline(token: Target, cache: Bool = false, cacheKey: String = "", needCache: Bool = false, isCache: Bool = false) -> Observable<Moya.Response> {
        
            return Observable.create { [weak self] observer -> Disposable in
            
            if !(NetworkReachabilityManager()?.isReachable ?? false) {
                
                observer.onError(RxSwiftMoyaError.RXSwiftMoyaNoNetwork)
            }
            
            let cancellableToken = self?.request(token) { result in
                switch result {
                case let .success(response):
                    
                    observer.onNext(response)
                    observer.onCompleted()
                    
                case let .failure(error):
                    
                    if !NetworkReachabilityManager()!.isReachable {
                        // 没有网络
                        observer.onError(RxSwiftMoyaError.RXSwiftMoyaNoNetwork)
                    }else {
                        if (error as NSError).code == -1001 {
                            observer.onError(RxSwiftMoyaError.RXSwiftMoyaNoNetwork)
                        }else {
                            observer.onError(RxSwiftMoyaError.RxSwiftMoyaNotSuccessfulHTTP)
                        }
                    }
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    
}


