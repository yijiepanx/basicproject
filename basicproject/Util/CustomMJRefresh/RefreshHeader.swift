//
//  VPLoadingHeader.swift
//  Vape
//
//  Created by Levin on 2017/3/16.
//  Copyright © 2017年 范国徽. All rights reserved.
//

import UIKit
import MJRefresh
 
class RefreshHeader: MJRefreshStateHeader {

    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .white)
        return view
    }()

    override func placeSubviews() {
        super.placeSubviews()
        // 圈圈
        if (self.loadingView.constraints.count == 0) {
            self.loadingView.center = CGPoint(x: self.mj_w * CGFloat(0.5), y: self.mj_h * CGFloat(0.5))
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loadingView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {

        super.prepare()

        // Hide the time
        lastUpdatedTimeLabel?.isHidden = true;

        // Hide the status
        stateLabel?.isHidden = true;


    }

    override var state: MJRefreshState {
        set {
            let oldState: MJRefreshState = state
            if newValue == oldState{

            }else{
                super.state = newValue
            }
            self.loadingView.isHidden = false
            if newValue == MJRefreshState.idle {
                self.loadingView.stopAnimating()
                debugPrint("newValue", "idle")
            } else if newValue == .pulling{
                self.loadingView.startAnimating()
                debugPrint("newValue", "pulling")
            } else if newValue == .refreshing{
                self.loadingView.startAnimating()
                debugPrint("newValue", "refreshing")
            }else if newValue == MJRefreshState.noMoreData{
                self.loadingView.isHidden = true
            }

        }
        get{
            return super.state
        }
    }


}
