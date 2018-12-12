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

/// SVCTabBarDelegate
public protocol SVCTabBarMoveDelegate: class {
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

/// Type that merge SVCTabItemProtocol and UIView
public typealias SVCTabItemViewProtocol = (SVCTabItemProtocol & UIView)

/// SVCTabBar
public protocol SVCTabBarProtocol: class {
    /// items
    var items: [SVCTabItemViewProtocol] { get set }
    
    /// SVCTabBar delegate
    var delegate: SVCTabBarDelegate? { get set }
    
    /// SVCTabBarMoveDelegate
    var moveDelegate: SVCTabBarMoveDelegate? { get set }
    
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
