//
//  NSDecimalNumber+Extension.swift
//  FPVGreat
//
//  Created by youzu on 2020/12/7.
//

import UIKit

extension NSDecimalNumber {
    
    func decimalNumber(with scale: Int16) -> String {
        let decimalNumberHandler = NSDecimalNumberHandler.init(roundingMode: RoundingMode.plain, scale: scale, raiseOnExactness: false, raiseOnOverflow: true, raiseOnUnderflow: true, raiseOnDivideByZero: true)
        let roundNumber = rounding(accordingToBehavior: decimalNumberHandler)
        let numberFormat = NumberFormatter()
        var formatStr: String = "0."
        for _ in 0...scale-1 {
            formatStr.append("0")
        }
        numberFormat.positiveFormat = formatStr
        let numbStr = numberFormat.string(from: roundNumber) ?? "0.00"
        return numbStr
    }
}
