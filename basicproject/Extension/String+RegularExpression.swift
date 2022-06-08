//
//  String+RegularExpression.swift
//  FPVGreat
//
//  Created by youzu on 2020/11/13.
//

import UIKit

//at 高亮处理
extension String {
    func getAttributedStringWithAtinfoHightLight(with attrs: [NSAttributedString.Key : Any]?) -> NSMutableAttributedString {
        
        func findAimstrAllRange(baseStr : NSString, aimStr: String, baseRange : NSRange, result : inout Array<NSRange>) -> Array<NSRange> {
            let range = baseStr.range(of: aimStr, options: NSString.CompareOptions.literal, range: baseRange)
            //找到
            if range.length > 0{
                result.append(range)
                let detectLength = range.location + range.length
                let rangeNew = NSRange(location: detectLength, length: baseStr.length - detectLength)
                _ = findAimstrAllRange(baseStr: baseStr, aimStr: aimStr, baseRange: rangeNew, result: &result)
            }
            return result
        }
        
        //start
        
        let regex_http = "<a href=(?:.*?)>(.*?)<\\/a>"
        let labelText = self
        
        let  regularExp = try? NSRegularExpression(pattern: regex_http, options: NSRegularExpression.Options.caseInsensitive)

        let resultArr = regularExp?.matches(in: labelText, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, labelText.count))
        
        
        if let tempReult = resultArr ,tempReult.count > 0{

            var changeTuples : [(NSRange,String,String)] = []
            
            var tempFullStr = labelText
            tempFullStr = tempFullStr.replacingOccurrences(of: "<a href=(.*?)>", with: "", options: String.CompareOptions.regularExpression)
            tempFullStr = tempFullStr.replacingOccurrences(of: "<\\/a>", with: "", options: String.CompareOptions.regularExpression)

            let fullAttr = NSMutableAttributedString(string: tempFullStr, attributes: attrs)
            
            for subRest in tempReult {
//                print("fullInRange - \(subRest.range)")
                
                let tempTT = (labelText as NSString).substring(with: subRest.range)
                var nameTT = tempTT
                nameTT = nameTT.replacingOccurrences(of: "<a href=(.*?)>", with: "", options: String.CompareOptions.regularExpression)
                nameTT = nameTT.replacingOccurrences(of: "<\\/a>", with: "", options: String.CompareOptions.regularExpression)
      
                //获取名字range 存在处理重复名字问题
                var rangeArr = Array<NSRange>()
                let sameNameArr = findAimstrAllRange(baseStr: tempFullStr as NSString, aimStr: nameTT, baseRange: NSMakeRange(0, tempFullStr.count), result: &rangeArr)
                
                //获取href value
                var herfValue = tempTT
                herfValue = herfValue.replacingOccurrences(of: "<a href=\"", with: "")
                herfValue = herfValue.replacingOccurrences(of: "\">\(nameTT)</a>", with: "")
                
                for sameRange in sameNameArr {
                    let tempTuple : (NSRange,String,String) = (sameRange,herfValue,nameTT)
                    changeTuples.append(tempTuple)
                }
            }
            
            //根据获取at数据  拼接字符串
            for attTuple in changeTuples {
                let yyheightlight = YYTextHighlight(backgroundColor: UIColor.Hex(hexValue: 0xE0E1EB))
                yyheightlight.userInfo = ["linkUrl" : attTuple.1]
                fullAttr.yy_setTextHighlight(yyheightlight, range: attTuple.0)
                fullAttr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Hex(hexValue: 0x26ACFF), range: attTuple.0)
            }
            return fullAttr
        } else {
            return NSMutableAttributedString(string: labelText, attributes: attrs)
        }
    }
}

extension String {
    
    func valideRegulation(with: String) -> Bool {
        if self.count == 0 {
            return false
        }
        let regexMobile = NSPredicate(format: "SELF MATCHES %@", with)
        if regexMobile.evaluate(with: self) == true {
            return true
        }else{
            return false
        }
    }
    
    var isEmptyStr: Bool {
        guard !self.isEmpty else {
            return true
        }
        let string = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return string.isEmpty
    
    }
}

extension String {
    
    func sizeForComment(font: UIFont, size: CGSize = CGSize.init(width: 1000, height: 1000), maxNumberOfLines: Int = 0) -> CGSize {
        let rect = NSString(string: self).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        guard maxNumberOfLines > 0 else{
            return rect.size
        }
        let fontLineHeight = font.lineHeight*CGFloat(maxNumberOfLines)
        let realHeight = min(rect.size.height, fontLineHeight)
        return CGSize.init(width: rect.size.width, height: realHeight)
    }
    
    /// 计算文字显示区域
    /// - Parameters:
    ///   - text: 文字
    ///   - attributeString: 属性字符串
    ///   - fitsSize: 指定限制的尺寸
    ///   - numberOfLines: 指定最大显示的行数
    ///   - font: 文字大小,设置nil则使用Label默认的17号字体
    ///   - alignment: 文字的对齐方式，默认natural
    ///   - lineBreakMode: 指定多行文字断字模式，默认可以用UILabel的默认断字模式NSLineBreakByTruncatingTail
    ///   - minimumScaleFactor: 指定文本的最小缩放因子，默认填写0。这个参数用于那些定宽时可以自动缩小文字字体来自适应显示的场景。
    ///   - shadowOffSet: 指定阴影的偏移位置，需要注意的是这个偏移位置是同时指定了阴影颜色和偏移位置才有效。如果不考虑阴影则请传递CGSizeZero，否则阴影会参与尺寸计算。
    func calculateTextSize(text: String?,attributeString: NSAttributedString?, fitsSize: CGSize, numberOfLines: Int = 0, font: UIFont?, alignment: NSTextAlignment = .natural , lineBreakMode: NSLineBreakMode = .byTruncatingTail, minimumScaleFactor: CGFloat = 0, shadowOffSet: CGSize = CGSize.zero) -> CGSize{
        let calculateText: String = text ?? ""
        var attribute: NSAttributedString;
        if calculateText.count <= 0 {
            guard attributeString != nil else {
                return CGSize.zero
            }
            attribute = attributeString!
        }
        
        guard let textString = text else {
            return CGSize.zero
        }
        //文字大小
        let textFont: UIFont = font ??  UIFont.systemFont(ofSize: 17)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        if #available(iOS 11.0, *) {
            paragraphStyle.setValue(1, forKey: "lineBreakStrategy")
        }
        attribute = NSAttributedString.init(string: textString, attributes: [NSAttributedString.Key.font: textFont, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        if calculateText.count <= 0 {
            let mutableAttrbute = NSMutableAttributedString.init(string: attribute.string, attributes: [NSAttributedString.Key.font: textFont, NSAttributedString.Key.paragraphStyle: paragraphStyle])
            mutableAttrbute.enumerateAttributes(in: NSMakeRange(0, mutableAttrbute.string.count), options: NSAttributedString.EnumerationOptions.reverse) { (attrs, range, stop) in
                mutableAttrbute.addAttributes(attrs, range: range)
            }
            attribute = mutableAttrbute
        }
        var fitsSize_E = fitsSize
        //调整fitsSize的值, 这里的宽度调整为只要宽度小于等于0或者显示一行都不限制宽度，而高度则总是改为不限制高度。
        fitsSize_E.height = CGFloat.greatestFiniteMagnitude
        if fitsSize_E.width <= 0 || numberOfLines == 1 {
            fitsSize_E.width = CGFloat.greatestFiniteMagnitude
        }
        //构造出一个NSStringDrawContext
        let context = NSStringDrawingContext.init()
        context.minimumScaleFactor = minimumScaleFactor
        context.setValue(numberOfLines, forKey: "maximumNumberOfLines")
        if numberOfLines != 1 {
            context.setValue(true, forKey: "wrapsForTruncationMode")
        }
        context.setValue(true, forKey: "wantsNumberOfLineFragments")
        var rect = attribute.boundingRect(with: fitsSize_E, options: .usesLineFragmentOrigin, context: context)
        let scale = UIScreen.main.scale
        rect.size.width = ceil(rect.size.width * scale) / scale
        rect.size.height = ceil(rect.size.height * scale) / scale
        return rect.size
    }
    
    func isEqualTo(str: String) -> Bool{
       return self.compare(str) == .orderedSame
    }
        
}


extension Dictionary{
    
    func jsonString() -> String?{
        if let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) {
            
            let strJson = String.init(data: data, encoding: String.Encoding.utf8)
            return strJson
        }
        return nil
    }
}


extension String {
    
    func urlEncoded() -> String? {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString
    }
}


extension Double {
    func houreAndMinutesShow() -> String {
        let duration = self
        if duration < 3600 {
            return duration > 60 ? String(format: "%.0fm", ceil(duration/60)) : (duration <= 0 ? "0m" : "1m")
//            display_duration = String(format: "%.0fm", duration/60.0)
        }
        else{
            return String(format: "%.0fh%.0fm", floor(duration/3600.0),ceil(duration.truncatingRemainder(dividingBy: 3600.0)/60.0))
        }
    }
    func hourAndMinutesSecondShow()-> String{
        let second = self
        if second >= 3600 {
            return String(format: "%02.0f", floor(second/3600.0)) + ":" + String(format: "%02.0f", floor(second.truncatingRemainder(dividingBy: 3600.0)/60.0)) + ":" + String(format: "%02.0f", ceil(second.truncatingRemainder(dividingBy: 3600.0).truncatingRemainder(dividingBy: 60)))
        }
        else if second > 60{
            return String(format: "%02.0f", floor(second/60)) +  ":" + String(format: "%02.0f", ceil(second.truncatingRemainder(dividingBy:60.0)))
        }
        else{
            return String(format: "00:%02.0f", floor(second))
        }
    }
    
    var sizeShowStr: String {
        var sizeD = Int(self)
        var rest: Int = 0
        if sizeD < 1024 {
            return "\(String.init(format: "%dB", sizeD))"
        }else{
            sizeD = sizeD/1024
        }
        
        if sizeD < 1024 {
            return "\(String.init(format: "%dKB", sizeD))"
        }else{
            rest = sizeD%1024
            sizeD = sizeD/1024
        }
        
        if sizeD < 1024 {
            sizeD = sizeD*100
            return "\(String.init(format: "%d.%dMB", sizeD/100, rest*100/1024%100))"
        }else{
            sizeD = sizeD*100/1024
            return "\(String.init(format: "%d.%dGB", sizeD/100, sizeD%100))"
        }
    }

}

extension TimeInterval {
    
    var realVideoTimeShow: String {
        let seconds = Int(self)
        var totalTime: String = ""
        if seconds >= 3600 {
            let strHour = String.init(format: "%02ld", seconds/3600)
            totalTime += "\(strHour):"
        }
        
        let strMinus = String.init(format: "%02ld", (seconds%3600)/60)
        totalTime += "\(strMinus):"

        let strSeconds = String.init(format: "%02ld", seconds%60)
        totalTime += "\(strSeconds)"

        return totalTime
    }
}
//视频大小单位转化
extension String {
    var sizeShowStr: String {
        var sizeD = Int(self) ?? 0
        var rest: Int = 0
        if sizeD < 1024 {
            return "\(String.init(format: "%dB", sizeD))"
        }else{
            sizeD = sizeD/1024
        }
        
        if sizeD < 1024 {
            return "\(String.init(format: "%dKB", sizeD))"
        }else{
            rest = sizeD%1024
            sizeD = sizeD/1024
        }
        
        if sizeD < 1024 {
            sizeD = sizeD*100
            return "\(String.init(format: "%d.%dMB", sizeD/100, rest*100/1024%100))"
        }else{
            sizeD = sizeD*100/1024
            return "\(String.init(format: "%d.%dGB", sizeD/100, sizeD%100))"
        }
    }
}

extension String {
    
    var nuberShowStr: String {
        return self.isEmptyStr ? "0" : self
    }
    
    //加一
    var plusOneStr: String {
        let str = self
        if str.isEmptyStr || str.isEqualTo(str: "0"){
            return "1"
        }else{
            var norInt = Int(str) ?? 0
            norInt += 1
            return String.init(format: "%d", norInt)
        }
    }
    
    //减一
    var minusOneStr: String {
        let str = self
        if str.isEmptyStr || str.isEqualTo(str: "0") || str.isEqualTo(str: "1"){
            return "0"
        }else{
            var norInt = Int(str) ?? 0
            norInt -= 1
            norInt = norInt < 0 ? 0 : norInt
            return String.init(format: "%d", norInt)
        }
    }
}

extension String {
    
    func getAttributedStringByRegex(with keyword: String, onlyfirstRange: Bool = true,keycolor: UIColor = UIColor.init(hexString: "#FF922C"), keyfont: UIFont = UIFont.systemFont(ofSize: 13), normalColor: UIColor = UIColor.init(hexString: "#E0E1EB"), normalFont: UIFont = UIFont.systemFont(ofSize: 13)) -> NSAttributedString?{
        guard !self.isEmpty else {
            return nil
        }
        let string = self
        let regex = try? NSRegularExpression(pattern: keyword, options: NSRegularExpression.Options.caseInsensitive)
        // 1.3.开始匹配
        let regexRes = regex?.matches(in: string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, string.count))
        let normalAttri = NSMutableAttributedString.init(string: string, attributes: [.font: normalFont, .foregroundColor: normalColor])
        
        guard let res = regexRes else {
            return normalAttri
        }
        guard !onlyfirstRange, res.count > 0 else{
            if let first = res.first {
                normalAttri.addAttributes([.font: keyfont, .foregroundColor: keycolor], range: first.range)
            }
            return normalAttri
        }
        for checkingRes in res{
            normalAttri.addAttributes([.font: keyfont, .foregroundColor: keycolor], range: checkingRes.range)
        }
        return normalAttri
//        return normalAttri.attributedSubstring(from: NSRange.init(location: 0, length: string.count))
    }
    
    func getAttributedString(normalColor: UIColor = UIColor.init(hexString: "#E0E1EB"), normalFont: UIFont = UIFont.systemFont(ofSize: 13)) -> NSAttributedString?{
        guard !self.isEmpty else {
            return nil
        }
        let string = self
        let normalAttri = NSMutableAttributedString.init(string: string, attributes: [.font: normalFont, .foregroundColor: normalColor])
        return normalAttri
//        return normalAttri.attributedSubstring(from: NSRange.init(location: 0, length: string.count))
    }
    
}

extension String {
    var combinaHtmlString: String {
        var currentHtmlStr = self
        if !currentHtmlStr.containHeaderStyle() {
            let head = "<head>" +
                "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\"> " +
                "<style>body{padding: 5;margin: 20;} img{max-width: 100%; width:auto; height:auto;} body{font-size:16px;font-family:'HelveticaNeue';word-wrap:break-word;}</style>" +
                "</head>";
            currentHtmlStr = "<html>" + head + "<body>" + self  + "</body></html>";
        }
        return currentHtmlStr
    }
    
    //将黑色字体的样式，转换为白色字体样式
    var whiteStyleStr: String {
        let normalStr = self
        let regex = try? NSRegularExpression(pattern: "<head>", options: NSRegularExpression.Options.caseInsensitive)
        let fontSize: CGFloat = 13
        let result = regex?.stringByReplacingMatches(in: normalStr, options: [], range: NSMakeRange(0, normalStr.count), withTemplate:  "<head> <style>*{color:#9295A3 !important;font-size:\"+ \(fontSize) + \"px !important;}</style>")
        return result ?? normalStr
    }
    
    func containHeaderStyle() -> Bool {
        let regex = try? NSRegularExpression(pattern: "<head>", options: NSRegularExpression.Options.caseInsensitive)
        // 1.3.开始匹配
        let string = self
        let regexRes = regex?.matches(in: string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, string.count))
        return (regexRes?.count ?? 0) > 0
    }

}
