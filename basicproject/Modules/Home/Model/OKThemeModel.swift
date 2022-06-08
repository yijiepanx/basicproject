//
//  OKThemeModel.swift
//  okart
//
//  Created by panyijie on 2022/5/18.
//

import UIKit
import HandyJSON

class OKThemeDataModel: HandyJSON {
    
    var count : Int = 0
    var series = [OKThemeModel]()
    
    required init() {}
}


/**
主题销售状态
 */
enum OKThemeSaleStatus : Int, HandyJSONEnum {
    case onSale = 0
    case saleOut
    case forSale
}

class OKThemeModel: HandyJSON {
    
    var seriesname : String = ""
    var seriesid : Int = -1
    var prvurl : String = ""
    var developer : String = ""
    var devurl : String = ""
    
    var releasetime : Double = 0
    var soldout : Int = 1
    
    //detail 存在参数
    var seriesbg : String = ""
    var seriestext : String = ""
    var apmcount : Int = 1
    var itemcount : Int = 1
    var goods = [OKGoodModel]()
    
    //cal
    var saleStatus : OKThemeSaleStatus = .saleOut
    var saleString : String = "已售罄"
    
    var seriesAttrStr : NSAttributedString?
    var seriesTextH : CGFloat = 0
    
    
    required init() {}
    
    func didFinishMapping() {
        
        calculateSaleStatus()
        calculateIntroText()
    }
    
    func calculateSaleStatus()  {
        if soldout == 1 {
            //售罄
            saleStatus = .saleOut
            saleString = "已售罄"
        } else {
            let nowTimes = NSDate().timeIntervalSince1970
            if releasetime > nowTimes {
                //待发售
                saleStatus = .saleOut
                
                let reDate = Date(timeIntervalSince1970: releasetime)
                let dateForm = DateFormatter()
                dateForm.dateFormat = "MM/dd HH:mm"
                let string = dateForm.string(from: reDate)
                
                saleString = string + "发售"
            } else {
                //发售中
                saleStatus = .onSale
                saleString = "发售中"
            }
            
        }
    }
    
    func calculateIntroText()  {
//        seriestext = "早期到达欧洲的中国瓷器是王侯贵胄千金难求的收藏，在文艺复兴时期的画作中被描绘成诸神与圣徒使用的器皿，带有神圣的色彩。流行的静物画再现了当时富裕家庭的室内陈设和艺术喜好，墙面、壁炉、橱柜上装饰着来自中国的瓷器构成象征财富与地位的符号。"
        
        let descString = "\(seriestext)"
        let maDescString = NSMutableAttributedString(string: descString)
        maDescString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12.5, weight: .regular), range: NSMakeRange(0, maDescString.length))
//        maDescString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Hex(hexValue: 0x9295A3), range: NSMakeRange(0, maDescString.length))
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 5
        paraStyle.lineBreakMode = .byTruncatingTail
        maDescString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paraStyle, range: NSMakeRange(0, maDescString.length))
        maDescString.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: NSMakeRange(0, maDescString.length))
//        maTitleString.addAttribute(NSAttributedString.Key.kern, value: 0.5, range: NSMakeRange(0, maTitleString.length))
        
        let limitWidth = kScreenWidth - 60
        
        let countLab1 = UILabel()
        countLab1.numberOfLines = 0
        countLab1.attributedText = maDescString
        let fitHeight1 : CGFloat = countLab1.sizeThatFits(CGSize(width: limitWidth, height: CGFloat.greatestFiniteMagnitude)).height
        
        seriesAttrStr = maDescString
        seriesTextH = fitHeight1
        
    }
    
    
}



