//
//  UITextField+ClearButton.swift
//  FPVGreat
//
//  Created by youzu on 2020/12/31.
//

import UIKit

extension UITextField {
    
    struct Layout {
        static let leftImageViewSize: CGSize = UIImage.init(named: "txt_clear_button")?.size ?? CGSize.init(width: 15, height: 15)
        static let leftViewLeftMargin: CGFloat = 15
        static let leftViewRightMargin: CGFloat = 15
        static let leftViewSize = CGSize.init(width: leftImageViewSize.width + leftViewLeftMargin + leftViewRightMargin, height: 24)
    }
    
    func addRightClearBtn(barHeight: CGFloat = 24, handler: (() -> ())? = nil) {
        let clearImage = UIImage.init(named: "txt_clear_button")
        let searchIconSize = Layout.leftImageViewSize
        let codeNumbTxtField = self
        let coderightView = UIView()
        let marginTop = (Layout.leftViewSize.height - searchIconSize.height)/2
        coderightView.frame  = CGRect(x: 0, y: (barHeight - Layout.leftViewSize.height)/2, width: Layout.leftViewSize.width, height: Layout.leftViewSize.height)
        let codeleftButton = BaseButton()
        codeleftButton.contentHorizontalAlignment = .center
//        codeleftButton.addTarget(self, action: #selector(clearCodeTextAction), for: .touchUpInside)
        codeleftButton.handle(.touchUpInside) { [weak self] in
            guard let _ = self else { return }
            handler?()
        }
        codeleftButton.setImage(clearImage, for: .normal)
        codeleftButton.sizeToFit()
        codeleftButton.frame  = CGRect(x: Layout.leftViewLeftMargin, y: marginTop, width: searchIconSize.width, height:searchIconSize.height)
        coderightView.addSubview(codeleftButton)
        codeNumbTxtField.rightView = coderightView
        codeNumbTxtField.rightViewMode = .whileEditing
    }
    
    //更新placeholder文案
    func updatePlaceHolder(with: String, font: UIFont, color: UIColor) {
        let redPlaceholderText = NSAttributedString(string: with,
                                                    attributes: [NSAttributedString.Key.foregroundColor: color, .font: font])
        
        self.attributedPlaceholder = redPlaceholderText
    }
    
}
