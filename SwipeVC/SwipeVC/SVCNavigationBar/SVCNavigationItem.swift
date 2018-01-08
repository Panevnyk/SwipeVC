//
//  SVCNavigationItem.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 05.12.16.
//  Copyright © 2016 user. All rights reserved.
//

import UIKit

/// SVCNavigationItem
open class SVCNavigationItem: UIButton {
    
    /// init
    ///
    /// - Parameters:
    ///   - image: UIImage?
    ///   - target: Any?
    ///   - action: Selector?
    public convenience init(image: UIImage?, target: Any?, action: Selector?) {
        self.init()
        setImage(image, for: .normal)
        frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
        initializer()
    }

    /// init
    ///
    /// - Parameter title: String
    public convenience init(title: String) {
        self.init(frame: CGRect.zero)
        setTitle(title, for: UIControlState())
    }
    
    /// init
    ///
    /// - Parameter frame: CGRect
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initializer()
    }
    
    /// init
    ///
    /// - Parameter coder: NSCoder
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializer()
    }
    
    /// initializer
    private func initializer() {
        setTitleColor(UIColor.white, for: UIControlState())
        isExclusiveTouch = true
    }
}
