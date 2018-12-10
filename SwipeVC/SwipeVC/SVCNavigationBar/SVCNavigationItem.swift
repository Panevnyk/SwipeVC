//
//  SVCNavigationItem.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 05.12.16.
//  Copyright © 2016 Vlad Panevnyk. All rights reserved.
//

import UIKit

/// SVCNavigationItem
open class SVCNavigationItem: UIButton {
    
    // ---------------------------------------------------------------------
    // MARK: - Inits
    // ---------------------------------------------------------------------
    
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
        setTitle(title, for: UIControl.State())
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
    /// - Parameter aDecoder: NSCoder
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializer()
    }
    
    // ---------------------------------------------------------------------
    // MARK: - Methods
    // ---------------------------------------------------------------------
    
    /// initializer
    private func initializer() {
        setTitleColor(UIColor.white, for: UIControl.State())
        isExclusiveTouch = true
    }
}
