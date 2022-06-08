//
//  RefreshFooter.swift
//  FPVGreat
//
//  Created by youzu on 2020/11/25.
//

import UIKit
import MJRefresh

class RefreshFooter: MJRefreshBackFooter {

    lazy var loadingView: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            view.hidesWhenStopped = true
            view.hidesWhenStopped = true
            return view
        } else {
            // Fallback on earlier versions
            let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
            view.hidesWhenStopped = true
            view.hidesWhenStopped = true
            return view
        }
    }()

    //文本内容，没有更多数据得时候显示
    lazy var stateLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "我是有底线的~"
        label.textColor = UIColor.init(hexString: "#666666")
        label.isHidden = true
        return label
    }()

     override func prepare(){
         super.prepare()
         initialize()
         self.mj_h = MJRefreshFooterHeight
     }

    override func placeSubviews() {
        super.placeSubviews()
        self.loadingView.center = CGPoint(x: self.mj_w * CGFloat(0.5), y: self.mj_h * CGFloat(0.5))
        self.stateLabel.frame = self.bounds
    }
    
     func initialize() {
         addSubview(loadingView)
         addSubview(stateLabel)
     }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]?) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]?) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]?) {
        super.scrollViewPanStateDidChange(change)
    }

     override var state: MJRefreshState {
         set {
             let oldState: MJRefreshState = state
             if newValue == oldState{
             }else{
                 super.state = newValue
             }
             if newValue == MJRefreshState.idle {
                 self.stateLabel.isHidden = true
                 self.loadingView.stopAnimating()
             }else if newValue == .pulling{
                self.stateLabel.isHidden = true
                self.loadingView.startAnimating()
            }else if newValue == .refreshing{
                 self.stateLabel.isHidden = true
                 self.loadingView.startAnimating()
             }else if newValue == .noMoreData{
                 self.loadingView.stopAnimating()
                 self.stateLabel.isHidden = false
             }
         }
         get{
             return super.state
         }
     }


}
