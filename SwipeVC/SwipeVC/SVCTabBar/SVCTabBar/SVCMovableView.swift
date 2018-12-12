//
//  SVCMovableView.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 12/12/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// SVCMovableView
open class SVCMovableView: UIView {

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
    
    open func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
    }
}
