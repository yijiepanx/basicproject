//
//  UIView+CellIdentifier.swift
//  FPVGreat
//
//  Created by youzu on 2020/11/16.
//

import UIKit


extension NSObject {
    
    /// The class's name
    class var ts_className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    
    /// The class's identifier, for UITableView，UICollectionView register its cell
    class var ts_identifier: String {
        return String(format: "%@_identifier", self.ts_className)
    }
}
