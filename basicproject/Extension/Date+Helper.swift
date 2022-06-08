//
//  Date+Helper.swift
//  FPVGreat
//
//  Created by 赵德芳 on 2020/11/14.
//

import UIKit


extension Date {
    //获得当前时间的时间戳 秒
    var seconds: String {
        let internalTime = timeIntervalSince1970
        return String.init(format: "%.0f", internalTime)
    }
}


extension Date {
   
    func showDateForHoure() -> String {
        
        let time = self.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        
        let sec:Double = abs(now - time)
        let min:Double = round(sec/60)
        let hr:Double = round(min/60)
        let d:Double = round(hr/24)
//        let w:Double = round(d/7)
//        let m:Double = round(d/30)
//        let y:Double = round(d/365)
        
        if min <= 5 {
            return String.init(format: "刚刚")
        }
        if min < 60 {
            return String.init(format: "%.0f分钟前", min)
        }
        
        if hr < 24 {
            return String.init(format: "%.0f小时前", hr)
        }
        
        if d < 2 {
            return String.init(format: "昨天 \(dateToString(format: "HH:mm"))")
        }
        
        if d < 3 {
            return String.init(format: "前天 \(dateToString(format: "HH:mm"))")
        }
        
        return String.init(format: "\(dateToString(format: "yyyy-MM-dd  HH:mm"))")

//        if w <= 1 {
//            return String.init(format: "%.0f天前", d)
//        }
//        if m <= 1 {
//            return String.init(format: "%.0f周前", w)
//        }
//        if m <= 12 {
//            return String.init(format: "%.0f月前", w)
//        }
//        return String.init(format: "%.0f年前", y)
    }
    //格式化时间
    func dateToString(format: String = "yyyy/MM/dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
}
