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

    /// Inits
    convenience public init(title: String, image: UIImage?) {
        self.init(frame: CGRect.zero)        
        setTitle(title, for: UIControlState())
        setImage(image, for: .normal)
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initializer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializer()
    }
    
    private func initializer() {
        backgroundColor = UIColor.clear
        setTitleColor(UIColor.black, for: UIControlState())
        isExclusiveTouch = true
    }
}
