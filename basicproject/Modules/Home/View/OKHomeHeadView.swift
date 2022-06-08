//
//  OKHomeHeadView.swift
//  okart
//
//  Created by panyijie on 2022/5/17.
//

import UIKit
import FSPagerView

class OKHomeHeadView: UIView {

    lazy var headContainer: UIView = {
        let view = UIView()
        return view
    }()
    lazy var headLogo: UIImageView = {
        let imgview = UIImageView()
        imgview.image = UIImage(named: "ok_home_logo_small")
        imgview.contentMode = .scaleAspectFit
        return imgview
    }()
    
    lazy var listView: ZKCycleScrollView = {
        let v = ZKCycleScrollView(frame: CGRect.zero, shouldInfiniteLoop: true)
//        v.backgroundColor = .white
        v.layer.cornerRadius = 8
        v.layer.masksToBounds = true
        v.dataSource = self
        v.delegate = self
        v.hidesPageControl = true
        v.isAutoScroll = true
        v.register(OKHomeHeaderBannerViewCell.self, forCellWithReuseIdentifier: OKHomeHeaderBannerViewCell.ts_identifier)
        return v
    }()
    lazy var pageControl: FSPageControl = {
        let pageControl = FSPageControl()
//        pageControl.contentInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        pageControl.contentHorizontalAlignment = .center
        pageControl.setFillColor(UIColor(hexValue: 0xAAAAAA), for: .normal)
        pageControl.setFillColor(UIColor.white, for: .selected)
//        pageControl.setStrokeColor(UIColor.purple, for: .selected)
//        pageControl.setStrokeColor(UIColor.purple, for: .normal)
        pageControl.itemSpacing = 4
//        pageControl.backgroundColor = .cyan
        pageControl.interitemSpacing = 7
        return pageControl
    }()
   
    // MARK: - Property
    var bannerModels = [OKHomeBannerModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = kPrimaryBlack
        initSubviews()
        
        reload(with: [])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func reload(with models : [OKHomeBannerModel]) {
        self.bannerModels = models
        if models.count > 0 {
        }
        pageControl.numberOfPages = models.count
        pageControl.currentPage = 0
        self.listView.reloadData()
    }
    

}

extension OKHomeHeadView : ZKCycleScrollViewDataSource ,ZKCycleScrollViewDelegate {
    func numberOfItems(in cycleScrollView: ZKCycleScrollView) -> Int {
        bannerModels.count
    }
    
    func cycleScrollView(_ cycleScrollView: ZKCycleScrollView, cellForItemAt index: Int) -> ZKCycleScrollViewCell {
        let cell = cycleScrollView.dequeueReusableCell(withReuseIdentifier: OKHomeHeaderBannerViewCell.ts_identifier, for: index) as! OKHomeHeaderBannerViewCell
        cell.backgroundColor = UIColor.Hex(hexValue: 0x313131)
        
        return cell
    }
    
    func cycleScrollView(_ cycleScrollView: ZKCycleScrollView, didScrollFromIndex fromIndex: Int, toIndex: Int) {
        pageControl.currentPage = toIndex
    }
    
    func cycleScrollView(_ cycleScrollView: ZKCycleScrollView, didSelectItemAt index: Int) {
            
        
    }
        
}


extension OKHomeHeadView  {
    func initSubviews() {
        addSubview(headContainer)
        headContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(72)
        }
        headContainer.addSubview(headLogo)
        headLogo.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.bottom.equalToSuperview()
        }
        
        addSubview(listView)
        listView.snp.makeConstraints { make in
            make.top.equalTo(headContainer.snp.bottom)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(104 * kIPhone6WidthScale)
        }
        
        addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(listView.snp.bottom).offset(0)
            make.left.right.equalTo(listView)
            make.height.equalTo(20)
        }
        
        
    }
    
}




//自定义轮播cell
class OKHomeHeaderBannerViewCell: UICollectionViewCell {
    lazy var tIcon: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFill
        imgv.layer.masksToBounds = true
        return imgv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(tIcon)
        tIcon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
