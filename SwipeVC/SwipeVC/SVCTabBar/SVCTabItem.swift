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
    /// Item index
    public var itemIndex = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        setTitleColor(.black, for: .selected)
        setTitleColor(.gray, for: .normal)
        tintColor = UIColor.clear
    }
    
    /// updateStyle
    ///
    /// - Parameters:
    ///   - toIndex: move to ViewController index
    ///   - fromIndex: move from ViewController index
    ///   - percent: from 0 - 1, where 0 - 0%, 1 - 100%
    ///   - isTap: if true - moving is a result of tap to item, if false - moving is a resultof scroll
    ///   - duration: duration of animation
    open func updateStyle(toIndex: Int, fromIndex: Int, percent: CGFloat, isTap: Bool, duration: TimeInterval) {
        updateTitleColorStyle(toIndex: toIndex, fromIndex: fromIndex, percent: percent, isTap: isTap, duration: duration)
    }
    
    /// updateTitleColorStyle
    ///
    /// - Parameters:
    ///   - toIndex: move to ViewController index
    ///   - fromIndex: move from ViewController index
    ///   - percent: from 0 - 1, where 0 - 0%, 1 - 100%
    ///   - isTap: if true - moving is a result of tap to item, if false - moving is a resultof scroll
    ///   - duration: duration of animation
    open func updateTitleColorStyle(toIndex: Int, fromIndex: Int, percent: CGFloat, isTap: Bool, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            let selectedColor = self.titleColor(for: .selected) ?? .black
            let normalColor = self.titleColor(for: .normal) ?? .black
            let realPercent = toIndex == self.itemIndex ? 1 - percent : percent
            
            self.titleLabel?.textColor = selectedColor.getCombineColor(percent: realPercent,
                                                                        toColor: normalColor)
        }) { _ in
            if percent == 0 || percent == 1 {
                let realPercent = toIndex == self.itemIndex ? 1 - percent : percent
                
                self.isSelected = realPercent == 0
            }
        }
    }
}
