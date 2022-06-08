//
//  ScrollViewEmptyView.swift
//  FPVGreat
//
//  Created by youzu on 2020/11/17.
//

import UIKit
import SnapKit

class UIGradientView: UIView {
    
    struct Layout {
        static let minTipsWidth: CGFloat = 70
        
        static let btnTopMargin: CGFloat = 25
        static let btnSize: CGSize = CGSize.init(width: 138, height: 40)

        static let desTopMargin: CGFloat = 26
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = Layout.btnSize.height/2
        self.layer.masksToBounds = true
        //定义渐变的颜色（从黄色渐变到橙色）
        let topColor = UIColor.init(hexString: "#FD1A4C")
        let buttomColor = UIColor.init(hexString: "#FF4D54")
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0, 1]
        
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 0.5)
        //设置其CAGradientLayer对象的frame，并插入view的layer
        self.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ScrollViewEmptyView: UIView {
    
    typealias ScrollEmptyViewData = (type: emptyType, image: UIImage?, des: String?)
    
    var tapActionHandler: (() -> ())?

    struct EmptyData {
        
        static let normalData: ScrollEmptyViewData = (type: .normal, image: nil, des: nil)
        static let networkData: ScrollEmptyViewData = (type: .networkerror, image: UIImage.init(named: "network_error"), des: "页面加载失败，请重试")
        static let emptyData: ScrollEmptyViewData = (type: .nocontent, image: UIImage.init(named: "no_data"), des: "暂无数据")
        static let severErrorData: ScrollEmptyViewData = (type: .serverbusy, image: UIImage.init(named: "img_request_failed"), des: "页面加载失败，请重试")

        //搜索
        static let searchNoData: ScrollEmptyViewData = (type: .nocontent, image: UIImage.init(named: "search_empty"), des: "无相关内容, 换个关键词试试吧")
        
        //搜索
        static let studyNoData: ScrollEmptyViewData = (type: .nocontent, image: UIImage.init(named: "no_data"), des: "暂无课程")
        
        //视频已经被删除
        static let deleteVideo: ScrollEmptyViewData = (type: .nocontent, image: UIImage.init(named: "network_error"), des: "视频已经被删除")
    }
  
    lazy var backView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.sizeToFit()
        return imgView
    }()
  
    lazy var descLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.init(hexString: "#9295A3")
        label.textAlignment = .center
        label.numberOfLines = 2
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width*0.6
        label.sizeToFit()
        return label
        
    }()
    
//    lazy var tipLab: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 18)
//        label.textColor =  UIColor.init(hexString: "#2F8DFF")
//        label.textAlignment = .center
//        label.numberOfLines = 2
//        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width*0.6
//        label.text = "刷新一下"
//        label.sizeToFit()
//        return label
//    }()
    
    lazy var playBtn: BaseButton = {
        let button = BaseButton.init(frame: CGRect.init(x: 0, y: 0, width: Layout.btnSize.width, height: Layout.btnSize.height))
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("刷新一下", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#FFFFFF"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.sizeToFit()
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.setContentHuggingPriority(.required, for: .horizontal)
//        button.clipsToBounds = true
//        button.backgroundColor = UIColor.init(hexString: "#FD1A4C")
//        button.layer.cornerRadius = Layout.btnSize.height/2
        button.isHidden = true
        
      
        return button
    }()
    
    //UIGradientView
    lazy var backGradView: UIGradientView = {
        let button = UIGradientView.init(frame: CGRect.init(x: 0, y: 0, width: Layout.btnSize.width, height: Layout.btnSize.height))
        return button
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        initialize()
    }
 
    var dataForEmpty: ScrollEmptyViewData? {
        didSet {
            guard let emptyData = dataForEmpty else {
                return
            }
            self.emptyTitleType = emptyData.type
            self.imageView.image = emptyData.image
            self.descLabel.text = emptyData.des
            self.backView.isHidden = emptyData.type == .normal
            self.playBtn.isHidden = self.backView.isHidden == true ? true : (emptyData.type == .nocontent)
            self.backGradView.isHidden = self.playBtn.isHidden

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    struct Layout {
        static let minTipsWidth: CGFloat = 70
        
        static let btnTopMargin: CGFloat = 25
        static let btnSize: CGSize = CGSize.init(width: 138, height: 40)

        static let desTopMargin: CGFloat = 10
    }
    
    var emptyTitleType: emptyType = .normal
    
    func initialize(){
        self.sizeToFit()
        self.backgroundColor = UIColor.init(hexString: "#13141E")
        self.addSubview(backView)
        backView.addSubview(backGradView)
        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        backView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        backView.addSubview(descLabel)
        
        descLabel.snp.makeConstraints {
            
            $0.top.equalTo(imageView.snp.bottom).offset(Layout.desTopMargin)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
//            $0.bottom.equalToSuperview()

        }
        playBtn.handle(.touchUpInside) {
            [weak self] in
            self?.tapActionHandler?()
        }
        backView.addSubview(playBtn)
        playBtn.snp.makeConstraints {
            
            $0.top.equalTo(descLabel.snp.bottom).offset(Layout.btnTopMargin)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Layout.btnSize)
            $0.bottom.equalToSuperview()
        }
        backGradView.snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).offset(Layout.btnTopMargin)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Layout.btnSize)
            $0.bottom.equalToSuperview()
        }
        self.dataForEmpty = EmptyData.normalData
    }
    deinit {
        debugPrint(type(of: self), "deinit")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event)
    }

}
