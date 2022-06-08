//
//  NSAttributedString+Extension.swift
//  FPVGreat
//
//  Created by youzu on 2021/1/6.
//

import UIKit


extension NSAttributedString {
    
    //计算富文本的高度
    func sizeWithBoundingRectFor(size: CGSize = CGSize.init(width: 1000, height: 1000)) -> CGSize {
        let recSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).size
        return recSize
    }
    
    
    
    
    
}
