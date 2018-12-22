//
//  SVCTabBar.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 8/21/17.
//  Copyright © 2017 Vlad Panevnyk. All rights reserved.
//

import UIKit

/// SVCTabBar
open class SVCTabBar: UIView, SVCTabBarProtocol {
    
    // ---------------------------------------------------------------------
    // MARK: - Properties
    // ---------------------------------------------------------------------
    
    /// DefaultBackgroundColor
    public static let defaultBackgroundColor = UIColor(red: 0.980, green: 0.980, blue: 0.980, alpha: 1.0)
    
    /// Default switch bar height
    public static let defaultSwitchBarHeight: CGFloat = 44
    
    /// Switch bar items
    public var items: [SVCTabItemViewProtocol] = [] {
        willSet {
            clearItems(items)
            addItems(newValue)
        }
    }
    
    /// SVCTabBarDelegate
    public weak var delegate: SVCTabBarDelegate?
    
    /// SVCTabBarMoveDelegate
    public weak var moveDelegate: SVCTabBarMoveDelegate?
    
    /// Move view
    public lazy var movableView: SVCMovableView = {
        let view = SVCMovableView()
        return view
    }()
    
    /// Height of switch bar
    public var height: CGFloat = 44
    
    /// Inner space value
    public var tabBarSideInnerSpace: CGFloat = 0 {
        didSet {
            movableView.tabBarSideInnerSpace = tabBarSideInnerSpace
        }
    }
    
    // ---------------------------------------------------------------------
    // MARK: - Inits
    // ---------------------------------------------------------------------
    
    /// init
    ///
    /// - Parameter frame: CGRect
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    /// init
    ///
    /// - Parameter aDecoder: NSCoder
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    /// initialize
    open func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = SVCTabBar.defaultBackgroundColor
        addSubview(movableView)
    }

    // ---------------------------------------------------------------------
    // MARK: - Move
    // ---------------------------------------------------------------------
    
    /// move
    ///
    /// - Parameters:
    ///   - toIndex: Int
    ///   - fromIndex: Int
    ///   - percent: percent of change
    ///   - isTap: is method called after tap to item
    ///   - duration: duration for animation change
    open func move(toIndex: Int, fromIndex: Int, percent: CGFloat, isTap: Bool, duration: TimeInterval) {
        // animate move view
        movableView.animateMoveView(toIndex: toIndex, fromIndex: fromIndex, percent: percent, isTap: isTap, duration: duration)
        
        // SVCTabBarMoveDelegate
        moveDelegate?.move(toIndex: toIndex, fromIndex: fromIndex, percent: percent, isTap: isTap, duration: duration)
        
        // updateStyle
        items[toIndex].updateStyle(percent: percent)
        if toIndex != fromIndex {
            items[fromIndex].updateStyle(percent: 1 - percent)
        }
    }
}

// MARK: - Constraints
private extension SVCTabBar {
    func clearItems(_ items: [SVCTabItemViewProtocol]) {
        items.forEach { $0.removeFromSuperview() }
    }
    
    func addItems(_ items: [SVCTabItemViewProtocol]) {
        let allSpaces = 2 * tabBarSideInnerSpace
        
        for (i, item) in items.enumerated() {
            item.tag = i
            item.itemIndex = i
            item.delegate = self
            item.translatesAutoresizingMaskIntoConstraints = false
            addSubview(item)
      
            NSLayoutConstraint.activate([item.leadingAnchor.constraint(equalTo: i == 0 ? leadingAnchor : items[i - 1].trailingAnchor,
                                                                       constant: i == 0 ? tabBarSideInnerSpace : 0),
                                         item.topAnchor.constraint(equalTo: topAnchor),
                                         item.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / CGFloat(items.count),
                                                                     constant: -allSpaces / CGFloat(items.count)),
                                         bottomAnchor.constraint(equalTo: item.bottomAnchor)])
        }
        
        movableView.addMoveViewConstraints(to: self, itemsCount: items.count)
    }
}

// MARK: - SVCTabItemDelegate
extension SVCTabBar: SVCTabItemDelegate {
    public func didSelect(item: Int) {
        delegate?.select(item: item)
    }
}
