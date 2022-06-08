//
//  OKGoodModel.swift
//  okart
//
//  Created by panyijie on 2022/5/19.
//

import UIKit
import HandyJSON

class OKGoodDataModel: HandyJSON {
    
    var count : Int = 0
    var goods = [OKGoodModel]()
    
    required init() {}
}


class OKGoodModel: HandyJSON {

    var name : String = ""
    var itemid : String = ""
    var prvurl : String = ""
    var developer : String = ""
    var devurl : String = ""
    
    var tag : String = ""
    var price : String = ""
    var type : String = ""
    
    var releasetime : Double = 0
    var quantity : Int = 0
    var remaincount : Int = 0
    var soldnum : Int = 0
    
    var datestring : String = ""
    var timestring : String = ""
    
    //detail参数存在差异需单独处理下
    var release : Double = 0
    var imgurl : String = ""
    var details : String = ""
    var remain : Int = 0
    var sellable : Bool = false
    
    
    //cal
    var saleStatus : OKThemeSaleStatus = .saleOut
    var saleString : String = "已售罄"
    
    required init() { }
    
    func didFinishMapping() {
        goodStatusInList()
        
    }
    
    func goodStatusInList()  {
        if remaincount <= 0 {
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
    
    func goodStatusInDetail()  {
        if remain <= 0 {
            //售罄
            saleStatus = .saleOut
            saleString = "已售罄"
        } else {
            let nowTimes = NSDate().timeIntervalSince1970
            if release > nowTimes {
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
    
    
    
}



//本地根据时间变化数据模型

class OKTimelineDateModel: HandyJSON {
    
    var releasetime : Double = 0
    var timeModels = [OKTimelineTimeModel]()
    
    var allGoodModels = [OKGoodModel]()
    var totalH : CGFloat = 0
    // section 40
    
    required init() {}
    
    func calculateTimeModels() {
        
        var dateKeySet : Array<String> = Array<String>()
        for tgoodModel in allGoodModels {
            dateKeySet.append(tgoodModel.timestring)
        }
        print(dateKeySet)
        dateKeySet = dateKeySet.unique4
        print(dateKeySet)
        
        var dategroupModels = [OKTimelineTimeModel]()
        for tkey in dateKeySet {
            let tmodel = OKTimelineTimeModel()
            tmodel.timestring = tkey
            dategroupModels.append(tmodel)
        }
        
        for tgoodModel in allGoodModels {
            for gruopModel in dategroupModels {
                if tgoodModel.timestring == gruopModel.timestring {
                    gruopModel.goodModels.append(tgoodModel)
                }
            }
        }
        timeModels = dategroupModels
        
        var totalHeight : CGFloat = 0
        for tTimeModel in timeModels {
            totalHeight += tTimeModel.calculateTimeGruopHeight()
        }
        totalHeight += 40
        totalH = totalHeight
    }
    
}

class OKTimelineTimeModel: HandyJSON {
    
    var timestring : String = ""
    var goodModels = [OKGoodModel]()
    
    //section 44
    
    required init() {}
    
    func calculateTimeGruopHeight() -> CGFloat {
        
        return CGFloat((125 * goodModels.count - 10) + 44)
        
    }
    
}
