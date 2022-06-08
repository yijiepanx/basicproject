//
//  ExampleBasicContentView.swift
//  ESTabBarControllerExample
//
//  Created by lihao on 2017/2/9.
//  Copyright © 2018年 Egg Swift. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class ESBasicContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.renderingMode = .alwaysOriginal
        self.itemContentMode = .alwaysOriginal
        self.insets = UIEdgeInsets.init(top: 8, left: 0, bottom: 0, right: 0)
        textColor = UIColor.init(hexString: "#B2B9BD")
        highlightTextColor = UIColor.init(hexString: "#2F8DFF")
        iconColor = UIColor.init(hexString: "#FFFFFF").withAlphaComponent(0.61)
        highlightIconColor = UIColor.init(hexString: "#FFFFFF")
        titleLabel.isHidden = true
//        backdropColor = UIColor.white
//        highlightBackdropColor = UIColor.white
//        backgroundColor = UIColor.white
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
