//
//  NetWorkObserManager.swift
//  FPVGreat
//
//  Created by youzu on 2020/12/3.
//

import UIKit
import Alamofire
import RxSwift

class NetWorkObserManager {
    
    enum state {
        case new
        case old
    }
    
//    typealias Element = han
    
    let reachiability = NetworkReachabilityManager()

    static let share = NetWorkObserManager()
    
    var beforeNetStatus: NetworkReachabilityManager.NetworkReachabilityStatus?
    
    var currentReachiability: NetworkReachabilityManager.NetworkReachabilityStatus? {
        return self.reachiability?.status
    }
    
    init() {
        
        beforeNetStatus = reachiability?.status
        reachiability?.startListening(onQueue: DispatchQueue.global(), onUpdatePerforming: { [weak self](status) in
            guard let `self` = self else { return }
            self.networkSubject.onNext([.old : self.beforeNetStatus, .new: status])
            self.beforeNetStatus = status
        })
    }
    
    typealias networkChangeObject = [state: NetworkReachabilityManager.NetworkReachabilityStatus?]
    
    var networkSubject = PublishSubject<networkChangeObject>()
    
    func networkChangeSubscript(finishHandler: ((networkChangeObject) -> ())?, dispose: DisposeBag) {
        networkSubject.subscribe(onNext: { (networkChangeObject) in
            finishHandler?(networkChangeObject)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dispose)
    }
    
}
