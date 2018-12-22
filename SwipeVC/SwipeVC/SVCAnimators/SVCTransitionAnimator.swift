//
//  SVCTransitionAnimator.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 12/18/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// SVCTransitionAnimator
open class SVCTransitionAnimator: SVCAnimator {
    /// transitionOptions
    public let transitionOptions: UIView.AnimationOptions
    
    /// duration
    open var duration: TimeInterval = 0.5
    
    /// init
    ///
    /// - Parameter transitionOptions: UIView.AnimationOptions
    public init(transitionOptions: UIView.AnimationOptions) {
        self.transitionOptions = transitionOptions
    }
    
    /// select onView method describe selection view animation
    ///
    /// - Parameter view: View that will be animated
    open func select(onView view: UIView) {
        UIView.transition(with: view,
                          duration: duration,
                          options: transitionOptions,
                          animations: {},
                          completion: { _ in })
    }
    
    /// deselect onView method describe deselection view animation
    ///
    /// - Parameter view: View that will be animated
    open func deselect(onView view: UIView) {}
}
