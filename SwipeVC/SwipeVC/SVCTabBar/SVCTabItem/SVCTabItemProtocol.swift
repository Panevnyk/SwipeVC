//
//  SVCTabItemProtocol.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 12/12/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// SVCTabItemProtocol
public protocol SVCTabItemProtocol: class {
    /// itemIndex
    var itemIndex: Int { get set }
    
    /// SVCTabBar delegate
    var delegate: SVCTabItemDelegate? { get set }
    
    /// updateStyle
    ///
    /// - Parameter percent: from 0 to 1, where 0 - unselected, 1 - selected
    func updateStyle(percent: CGFloat)
}

/// SVCTabBarDelegate
public protocol SVCTabItemDelegate: class {
    /// didSelect
    ///
    /// - Parameter item: Int
    func didSelect(item: Int)
}
