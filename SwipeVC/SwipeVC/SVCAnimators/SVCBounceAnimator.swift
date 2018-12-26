//
//  SVCBounceAnimation.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 12/12/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// SVCBounceAnimator
open class SVCBounceAnimator: SVCAnimator {
    /// bounceAnimation
    public let bounceAnimation = CAKeyframeAnimation(keyPath: Constants.AnimationKeys.scale)
    
    /// duration
    open var duration: TimeInterval = 0.5
    
    /// bounceValues
    open var bounceValues = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
    
    /// calculationMode
    open var calculationMode = CAAnimationCalculationMode.cubic
    
    /// init
    public init() {}
    
    /// select onView method describe selection view animation
    ///
    /// - Parameter view: View that will be animated
    open func select(onView view: UIView) {
        bounceAnimation.values = bounceValues
        bounceAnimation.duration = duration
        bounceAnimation.calculationMode = calculationMode
        
        view.layer.add(bounceAnimation, forKey: nil)
    }
    
    /// deselect onView method describe deselection view animation
    ///
    /// - Parameter view: View that will be animated
    open func deselect(onView view: UIView) {}
}
