//
//  VPAutoLoadingFooter.swift
//  Vape
//
//  Created by 范国徽 on 2019/7/26.
//  Copyright © 2019 ChenJianglin. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire

protocol VPAutoLoadingCustomViewProtocol {
    //传入视图的总高度, 也就是自定义footer的总高度（如果视图上下有自定义的上边距和下边距也必须自己加上）
    //自定义视图里面的点击事件，需要自己写
    var vov_viewSumHeight: CGFloat { get }
}
extension MJRefreshState {
    func sameHeightState(newState: MJRefreshState) -> Bool {
        if newState == .noMoreData && self != .noMoreData {
            return false
        }
        if newState != .noMoreData && self == .noMoreData {
            return false
        }
        return true
    }
}
//UIView Int
class VPAutoLoadingFooter: MJRefreshAutoFooter {
//    MJRefreshFooter(refreshingBlock: nil)
    //loading 动画
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

    var nomoreDataTitle: String?

    //文本内容，没有更多数据得时候显示
    lazy var stateLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "没有更多数据了"
        label.isHidden = true
        return label
    }()


    //设置距离底部的高度， 如果距离底部高度小于等于这个数值需要掉加载下一页数据接口
    var distanceToFooter: CGFloat = UIScreen.main.bounds.size.height*3

    //判断是否显示过网络异常的错误, 如果显示过就不显了（只会显示一次），如果没显示的话就会显示
    var isShowNoNetWorkErrorHUD: (Bool, Date) = (false, Date())
    //    //自定义的footer view
    var customFooterView: UIView?

    var customFooterHeight: CGFloat = MJRefreshFooterHeight

    //是否展示自定义空白视图
    var showCustomView: Bool {
       return customFooterView != nil
    }

    override func prepare(){
        super.prepare()
        self.mj_h = MJRefreshFooterHeight
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
     convenience init?(refreshingBlock: @escaping MJRefreshComponentAction, customView: VPAutoLoadingCustomViewProtocol? = nil){
        self.init(frame: .zero)
        self.refreshingBlock = refreshingBlock
        if let customFooter = customView, let customView = customFooter as? UIView {
            customFooterHeight = customFooter.vov_viewSumHeight
            customView.isHidden = true
            self.customFooterView = customView
            self.addSubview(customView)
        }
    }



    func initialize() {
        addSubview(loadingView)
        addSubview(stateLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateMJH(oldState: MJRefreshState, newState: MJRefreshState) -> Bool {
        let newHeight = self.showCustomView ? (newState == .noMoreData ? self.customFooterHeight : MJRefreshFooterHeight ) : MJRefreshFooterHeight
        let oldHeight = self.mj_h
        return newHeight - oldHeight > 0.01
    }
    override var state: MJRefreshState {
        set {
            let oldState: MJRefreshState = state
            if newValue == oldState{
            }else{
                super.state = newValue
            }
            let shouldUpdateHeight = self.updateMJH(oldState: oldState, newState: newValue)
            if shouldUpdateHeight && self.scrollView != nil{
                self.scrollView?.mj_insetB -= self.mj_h;
                self.mj_h = MJRefreshFooterHeight
            }
            self.customFooterView?.isHidden = true
            self.loadingView.isHidden = false
            if newValue == MJRefreshState.idle {
                self.stateLabel.isHidden = true
                self.loadingView.stopAnimating()
            } else if newValue == .pulling{
                self.stateLabel.isHidden = true
                self.loadingView.startAnimating()
            } else if newValue == .refreshing{
                self.stateLabel.isHidden = true
                self.loadingView.startAnimating()
            }else if newValue == MJRefreshState.noMoreData{
                self.loadingView.stopAnimating()
                self.loadingView.isHidden = true
                self.stateLabel.isHidden = false
                if let emptyTitle = self.nomoreDataTitle {
                    stateLabel.text = emptyTitle
                }else{
                    stateLabel.text = "没有更多数据了"
                }
                self.stateLabel.isHidden = self.showCustomView
                self.customFooterView?.isHidden = !self.showCustomView
                if shouldUpdateHeight{
                    self.mj_h = self.customFooterHeight
                    self.customFooterView?.layoutIfNeeded()
                }
            }
            if shouldUpdateHeight && self.scrollView != nil {
                self.scrollView?.mj_insetB += self.mj_h;
            }
        }
        get{
            return super.state
        }
    }


    override func placeSubviews() {
        super.placeSubviews()
        self.loadingView.center = CGPoint(x: self.mj_w * CGFloat(0.5), y: self.mj_h * CGFloat(0.5))
        self.stateLabel.frame = self.bounds
        self.customFooterView?.frame = self.bounds
    }
    override func executeRefreshingCallback() {
        DispatchQueue.global().async {
            if let refreshingBlock = self.refreshingBlock {
                refreshingBlock()
            }
//            if let target = self.refreshingTarget, let action = self.refreshingAction {
//                if target.responds(to: action){
//                    let _ = target.perform(action)
//                }
//            }
            if let target = self.refreshingTarget, target.responds(to: self.refreshingAction) {
                
                let _ = target.perform(self.refreshingAction)
                
            }
            if let beginRefreshingCompletionBlock = self.beginRefreshingCompletionBlock{
                beginRefreshingCompletionBlock()
            }
        }
    }
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        // 内容的高度
        super.scrollViewContentSizeDidChange(change)
         guard let scrollView = self.scrollView else { return }
//        let contentHeight = self.scrollView.mj_contentH + self.ignoredScrollViewContentInsetBottom;
        let contentHeight = scrollView.mj_contentH;
        // 表格的高度
//        let scrollHeight = self.scrollView.mj_h - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom + self.ignoredScrollViewContentInsetBottom;
        let scrollHeight = scrollView.mj_h - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom;
        // 设置位置和尺寸
        self.mj_y = max(contentHeight, scrollHeight)
    }
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        
        if self.state != MJRefreshState.idle || !self.isAutomaticallyRefresh || self.mj_y == 0 { return }
        guard let scrollView = self.scrollView else { return }
        if scrollView.mj_insetT + scrollView.mj_contentH > scrollView.mj_h {
            //内容超过一个屏幕
            let shouldRefreshDistance = scrollView.mj_contentH - scrollView.mj_h + self.mj_h * self.triggerAutomaticallyRefreshPercent + scrollView.mj_insetB - self.mj_h - self.distanceToFooter
            if scrollView.mj_offsetY >= shouldRefreshDistance {
                let oldValue = change["old"] as! CGPoint
                let newValue = change["new"] as! CGPoint
                if newValue.y <= oldValue.y { return }
                if scrollView.mj_offsetY <= 0 {
                    return
                }
                startRefresh()
            }
        }
    }

    func startRefresh(){
        let isReachable = NetworkReachabilityManager.init()?.isReachable ?? false
        if isReachable {
            self.beginRefreshing()
        }else {
            self.endRefreshing()
        }
    }
    /// footer手动自动刷新
    func footerAutoBeginDrag() {
        if self.window == nil && self.state == .willRefresh {
            self.state = .idle
        }
        
        guard let scrollView = self.scrollView else { return }
        if self.state != MJRefreshState.idle || !self.isAutomaticallyRefresh || self.mj_y == 0 { return }
        if scrollView.mj_insetT + scrollView.mj_contentH > scrollView.mj_h {
            //内容超过一个屏幕
            let shouldRefreshDistance = scrollView.mj_contentH - scrollView.mj_h + self.mj_h * self.triggerAutomaticallyRefreshPercent + scrollView.mj_insetB - self.mj_h - self.distanceToFooter
            if scrollView.mj_offsetY >= shouldRefreshDistance {
                self.autoBeginRefresh()
            }
        }
    }
    //在非window 页的时候强制调用上拉刷新，需要重写刷新方法
    func autoBeginRefresh() {
        UIView.animate(withDuration: TimeInterval(MJRefreshFastAnimationDuration)) {
            [weak self] in
            guard let  `self` = self else  { return }
            DispatchQueue.main.async {
                self.state = .refreshing
                self.setNeedsDisplay()
            }
        }
    }
}
