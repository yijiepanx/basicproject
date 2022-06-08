//
//  UIScrollView+Extension.swift
//  Vape
//
//  Created by Shawn on 2018/5/22.
//  Copyright © 2018年 ChenJianglin. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    
    var isHeaderRefreshing: Bool {
        
        guard let header = self.mj_header else { return false }
        return header.isRefreshing
    }
    
    var isFooterRefreshing: Bool {
        
        guard let footer = self.mj_footer else { return false }
        return footer.isRefreshing
    }
    
    /// 下拉刷新
    ///
    /// - Parameter block: 下拉回调
    func headerRefresh(block: @escaping () -> ()){
        
        let header =  RefreshHeader.init {
            block()
        }

        header.backgroundColor = UIColor.clear
        self.mj_header = header
    }
    
    /// 上拉刷新
    ///
    /// - Parameter block: 上拉回调bolck
//    func footerRefresh(customView: VPAutoLoadingCustomViewProtocol? = nil, block: @escaping () -> ()){
//        //        let footer = VPAutoLoadingFooter.init {
//        //            block()
//        //        }
//        let footer = VPAutoLoadingFooter.init(refreshingBlock: {
//            block()
//        }, customView: customView)
//        footer?.backgroundColor = UIColor.clear
//        self.mj_footer = footer
//    }
    func footerRefresh(block: @escaping () -> (),footerText: String? = "我是有底线的~"){
        let footer = RefreshFooter.init {
            block()
        }
        if let text = footerText {
            footer.stateLabel.text = text
        }
        footer.backgroundColor = UIColor.clear
        self.mj_footer = footer
    }
    
    /// 开始下拉刷新动作
    func beginHeadRefreshing() {
        if let header = self.mj_header{
            header.beginRefreshing()
        }
    }
    
    /// 开始footer刷新动作
       func beginFooterRefreshing() {
           if let footer = self.mj_footer{
               footer.beginRefreshing()
           }
       }
    
    /// 结束头部刷新动作
    func endHeaderRefresh() {
        
        self.mj_header?.endRefreshing()
        
    }
    
    /// 结束底部刷新动作
    func endFooterRefresh() {
        
        self.mj_footer?.endRefreshing()
        
    }
    
    /// 结束所有刷新动作
    func endRefresh(){
        if let footer = self.mj_footer{
            footer.endRefreshing()
        }
        if let header = self.mj_header {
            header.endRefreshing()
        }
    }
    
    /// 结束上拉刷新并提示没有更多数据
    func endRefreshingWithNoMoreData() {
        
        if let footer = self.mj_footer{
            footer.endRefreshingWithNoMoreData()
        }
    }
    
    /// 重置无更多数据状态
    func resetNoMoreDataState() {
        if let footer = self.mj_footer{
            footer.resetNoMoreData()
        }
    }
    
    /// ignoredScrollViewContentInsetBottom -- 忽略底部缩进高度
    func ignoredFooterContentInsetBottom(_ bottomHeight: CGFloat ) {
        self.mj_footer?.ignoredScrollViewContentInsetBottom = bottomHeight
    }
    
    /// 结束上拉刷新并提示没有更多数据 totalPage <= 1的时候
    func endRefreshingWithNoMoreData(totalPage: UInt?) {
        if let page = totalPage, page <= 1 {
            self.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
    
}
