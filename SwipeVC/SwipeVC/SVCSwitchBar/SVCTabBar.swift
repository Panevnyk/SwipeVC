//
//  SVCTabBar.swift
//  SVCSwipeViewControllerSwift
//
//  Created by user on 18.04.16.
//  Copyright © 2016 user. All rights reserved.
//

import UIKit

/// SVCTabBarType
///
/// - top: attach to top
/// - bottom: attach to bottom
public enum SVCTabBarType {
    case top
    case bottom
}

/// SVCMoveViewAttach
///
/// - top: attach to top
/// - bottom: attach to bottom
public enum SVCMoveViewAttach {
    case top
    case bottom
}

/// SVCTabBarDelegate
public protocol SVCTabBarDelegate: class {
    /// select
    ///
    /// - Parameter item: Int
    /// - Returns: Bool
    @discardableResult
    func select(item: Int) -> Bool
}

/// SVCTabBar
public protocol SVCTabBar: class {
    var items: [UIView] { get set }
    weak var delegate: SVCTabBarDelegate? { get set }
    var height: CGFloat { get set }
    /// move
    func move(toIndex: Int, fromIndex: Int, percent: CGFloat, isTap: Bool, duration: TimeInterval)
}
