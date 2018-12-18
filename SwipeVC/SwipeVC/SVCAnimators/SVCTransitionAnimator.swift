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
    /// duration
    public static let duration = 0.5
    
    /// transitionOptions
    public let transitionOptions: UIView.AnimationOptions
    
    /// init
    ///
    /// - Parameter transitionOptions: UIView.AnimationOptions
    public init(transitionOptions: UIView.AnimationOptions) {
        self.transitionOptions = transitionOptions
    }
    
    open func select(onView view: UIView) {
        UIView.transition(with: view, duration: TimeInterval(SVCTransitionAnimator.duration), options: transitionOptions, animations: {
        }, completion: { _ in
        })
    }
    
    open func deselect(onView view: UIView) {}
}
