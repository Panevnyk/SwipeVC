//
//  SVCTabBar.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Vlad Panevnyk on 18.04.16.
//  Copyright © 2016 Vlad Panevnyk. All rights reserved.
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
    /// SVCTabBar delegate
    weak var delegate: SVCTabBarDelegate? { get set }
    /// tab bar height
    var height: CGFloat { get set }
    
    /// move
    ///
    /// - Parameters:
    ///   - toIndex: move to ViewController index
    ///   - fromIndex: move from ViewController index
    ///   - percent: from 0 - 1, where 0 - 0%, 1 - 100%
    ///   - isTap: if true - moving is a result of tap to item, if false - moving is a resultof scroll
    ///   - duration: duration of animation
    func move(toIndex: Int, fromIndex: Int, percent: CGFloat, isTap: Bool, duration: TimeInterval)
}
