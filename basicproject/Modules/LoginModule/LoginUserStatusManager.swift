//
//  LoginUserStatusManager.swift
//  FPVGreat
//
//  Created by youzu on 2020/12/4.
//

import UIKit
import Alamofire
import RxSwift

class LoginUserStatusManager {
   
    static let share = LoginUserStatusManager()
    
    private init() {
        
//        beforeNetStatus = reachiability?.status
//        reachiability?.startListening(onQueue: DispatchQueue.global(), onUpdatePerforming: { [weak self](status) in
//            guard let `self` = self else { return }
//            self.networkSubject.onNext([.old : self.beforeNetStatus, .new: status])
//            self.beforeNetStatus = status
//        })
    }
    typealias LoginUserModel = (isLogin: Bool, loginUser: SSaiLoginUser?)

    typealias userChangeObject = [NetWorkObserManager.state: LoginUserModel]
    
    var networkSubject = PublishSubject<userChangeObject>()
    
    func userLoginAction(obj: userChangeObject) {
        networkSubject.onNext(obj)
    }
    
    func userChangeSubscript(finishHandler: ((userChangeObject) -> ())?, dispose: DisposeBag) {
        networkSubject.subscribe(onNext: { (networkChangeObject) in
            finishHandler?(networkChangeObject)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dispose)
    }
    
}
