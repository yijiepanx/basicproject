//
//  OKHomeBannerModel.swift
//  okart
//
//  Created by panyijie on 2022/5/19.
//

import UIKit
import HandyJSON

class OKHomeBannerDataModel: HandyJSON {
    
    var count : Int = 0
    var banners = [OKHomeBannerModel]()
    
    required init() {}
}


class OKHomeBannerModel: HandyJSON {
    
    var url : String = ""
    var parm : String = ""
    
    
    required init() {}
}
