//
//  +FPVExtension.swift
//  FPVGreat
//
//  Created by iOS_dev on 2021/8/20.
//

import Foundation


extension Double {
    
    var cleanFloatZero : String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    
}


