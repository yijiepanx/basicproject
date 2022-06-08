//
//  Array+Extension.swift
//  okart
//
//  Created by panyijie on 2022/5/19.
//

import UIKit

extension Array where Element:Hashable {
    var unique4: [Element] {
        var uniq = Set<Element>()
        uniq.reserveCapacity(self.count)
        return self.filter {
            return uniq.insert($0).inserted
        }
    }
}
