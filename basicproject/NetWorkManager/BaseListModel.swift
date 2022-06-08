

import UIKit
import HandyJSON

public class BaseListModel<T: HandyJSON>: HandyJSON {
        
    var page: UInt?
    var total_page: UInt?
    var list: [T]?
    
    required public init() {}

}

class BaseListStr: HandyJSON {

    var list: [String]?
    
    required init() {}

}


