//
//  SVCNavigationBar.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 05.12.16.
//  Copyright © 2016 Vlad Panevnyk. All rights reserved.
//

import UIKit

/// SVCNavigationBarDelegate
public protocol SVCNavigationBarDelegate: class {
    /// navigationBarLeftGroupItems
    ///
    /// - Returns: SVCNavigationItem for left group
    func navigationBarLeftGroupItems() -> [SVCNavigationItem]?
    /// navigationBarRightGroupItems
    ///
    /// - Returns: SVCNavigationItem for right group
    func navigationBarRightGroupItems() -> [SVCNavigationItem]?
    /// navigationBarTitle
    ///
    /// - Returns: String for bar title
    func navigationBarTitle() -> String?
    /// navigationBarBottomView
    ///
    /// - Returns: UIView for bottom bar view
    func navigationBarBottomView() -> UIView?
}

extension SVCNavigationBarDelegate {
    func navigationBarLeftGroupItems() -> [SVCNavigationItem]? { return nil }
    func navigationBarRightGroupItems() -> [SVCNavigationItem]? { return nil }
    func navigationBarTitle() -> String? { return nil }
    func navigationBarBottomView() -> UIView? { return nil }
}

/// SVCNavigationBar
public protocol SVCNavigationBar: class {
    /// updateBarUsing
    ///
    /// - Parameters:
    ///   - delegateFrom: for get from value
    ///   - delegateTo: for get to value
    ///   - percent: precent of change
    ///   - selectItem: current select item
    ///   - duration: duration for animation
    func updateBarUsing(delegateFrom: SVCNavigationBarDelegate?,
                        delegateTo: SVCNavigationBarDelegate?,
                        percent: CGFloat,
                        selectItem: Int,
                        duration: TimeInterval)
}
