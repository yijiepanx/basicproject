//
//  OKHomeLoginVerifyView.swift
//  okart
//
//  Created by panyijie on 2022/5/19.
//

import UIKit
import Moya
import RxSwift

class OKHomeLoginVerifyView: UIView {
    
    lazy var tlab: UILabel = {
        let lab = UILabel()
        lab.text = "登录海上博物，开启数字艺术之旅"
        lab.textColor = UIColor(hexValue: 0x0E0D35)
        lab.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return lab
    }()
    
    lazy var tbtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", for: .normal)
        btn.backgroundColor = UIColor(hexValue: 0x1A1A1A)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return btn
    }()

    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 13
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.Hex(hexValue: 0xF8DDA9)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OKHomeLoginVerifyView  {
    
    @objc private func loginAction() {
        requestUserLogin()
    }
    
    
}

extension OKHomeLoginVerifyView {
    func requestUserLogin()  {

    
        OKLoginApiProvider
            .tryUserIsOffline(token: .smslogin(mobile: "13372863526", vcode: "123456"))
            .asObservable()
            .mapSingleModel(SSaiLoginUser.self)
            .subscribe(onNext: {[weak self] dataModel in
                guard let `self` = self else{return}
                DispatchQueue.main.async {
                    //老的用户
                    let beforeLogin = SSaiLoginUser()
                    beforeLogin.refreshLoginUser(user: SSaiLoginUser.share)
                    let beforeModel = (isLogin: SSaiLoginManager.isUserLogin, loginUser: beforeLogin)
                    SSaiLoginManager().refreshAndCache(for: dataModel)
                    let afterModel = (isLogin: SSaiLoginManager.isUserLogin, loginUser: SSaiLoginUser.share)
                    LoginUserStatusManager.share.userLoginAction(obj: [.old: beforeModel, .new: afterModel])
                }
            }, onError: {[weak self] error in
                guard let `self` = self else{return}
                DispatchQueue.main.async {
                    self.getShowMoyaErrorForMsg(error: error, defaultMsg: "数据异常，请稍后再试")
                }
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: self.disposeBag)
        
    }
    
}


extension OKHomeLoginVerifyView  {
    func initSubviews()  {

        addSubview(tbtn)
        tbtn.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 30))
        }
        
        addSubview(tlab)
        tlab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(tbtn.snp.left).offset(-15)
        }
        
    
    }
    
    
}
