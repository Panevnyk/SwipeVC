//
//  SVCTabItem.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Vlad Panevnyk on 18.04.16.
//  Copyright © 2016 Vlad Panevnyk. All rights reserved.
//

import UIKit

/// SVCTabItem
open class SVCTabItem: UIButton {
    
    // ---------------------------------------------------------------------
    // MARK: - Public variables
    // ---------------------------------------------------------------------
    
    /// Item index
    public var itemIndex = 0
    
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
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    // ---------------------------------------------------------------------
    // MARK: - initialize
    // ---------------------------------------------------------------------
    
    private func initialize() {
        setTitleColor(.black, for: .selected)
        setTitleColor(.gray, for: .normal)
        tintColor = UIColor.clear
    }
}

// MARK: - Update
extension SVCTabItem {
    /// updateStyle
    ///
    /// - Parameters:
    ///   - percent: from 0 to 1, where 0 - unselected, 1 - selected
    ///   - isTap: if true - moving is a result of tap to item, if false - moving is a result of scroll
    ///   - duration: duration of animation
    func updateStyle(percent: CGFloat, isTap: Bool, duration: TimeInterval) {
        updateTitleColorStyle(percent: percent, isTap: isTap, duration: duration)
    }
    
    /// updateTitleColorStyle
    ///
    /// - Parameters:
    ///   - percent: from 0 to 1, where 0 - unselected, 1 - selected
    ///   - isTap: if true - moving is a result of tap to item, if false - moving is a resultof scroll
    ///   - duration: duration of animation
    open func updateTitleColorStyle(percent: CGFloat, isTap: Bool, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            let selectedColor = self.titleColor(for: .selected) ?? .black
            let normalColor = self.titleColor(for: .normal) ?? .black
            
            self.titleLabel?.textColor = selectedColor.getCombineColor(percent: percent,
                                                                       toColor: normalColor)
        }) { _ in
            if percent == 0 || percent == 1 {
                self.isSelected = percent == 1
            }
        }
    }
}
