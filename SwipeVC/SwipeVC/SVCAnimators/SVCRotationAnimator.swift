//
//  SVCRotationAnimator.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 12/18/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// SVCRotationAnimator
open class SVCRotationAnimator: SVCAnimator {
    /// rotateAnimation
    public let rotateAnimation = CABasicAnimation(keyPath: Constants.AnimationKeys.rotation)
    
    /// rotationDirection
    public let rotationDirection: SVCRotationDirection
    
    /// duration
    open var duration: TimeInterval = 0.5
    
    /// init
    ///
    /// - Parameter rotationDirection: SVCRotationDirection
    public init(rotationDirection: SVCRotationDirection = .right) {
        self.rotationDirection = rotationDirection
    }
    
    /**
     Animation direction
     - Left:  left direction
     - Right: right direction
     */
    public enum SVCRotationDirection {
        case left
        case right
    }
    
    /// select onView method describe selection view animation
    ///
    /// - Parameter view: View that will be animated
    open func select(onView view: UIView) {
        rotateAnimation.fromValue = 0.0
        
        let toValue: CGFloat
        switch rotationDirection {
        case .left:
            toValue = CGFloat.pi * -2.0
        case .right:
            toValue = CGFloat.pi * 2.0
        }
        
        rotateAnimation.toValue = toValue
        rotateAnimation.duration = duration
        
        view.layer.add(rotateAnimation, forKey: nil)
    }
    
    /// deselect onView method describe deselection view animation
    ///
    /// - Parameter view: View that will be animated
    open func deselect(onView view: UIView) {}
}
