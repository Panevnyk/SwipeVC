//
//  SVCItemAnimator.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 12/10/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// SVCAnimator
public protocol SVCAnimator {
    /// select onView method describe selection view animation
    ///
    /// - Parameter view: View that will be animated
    func select(onView view: UIView)
    
    /// deselect onView method describe deselection view animation
    ///
    /// - Parameter view: View that will be animated
    func deselect(onView view: UIView)
}
