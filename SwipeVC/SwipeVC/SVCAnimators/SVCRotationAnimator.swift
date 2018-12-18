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
    /// duration
    public static let duration = 0.5
    
    /// rotationDirection
    public let rotationDirection: SVCRotationDirection
    
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
    
    open func select(onView view: UIView) {
        let rotateAnimation = CABasicAnimation(keyPath: Constants.AnimationKeys.rotation)
        rotateAnimation.fromValue = 0.0
        
        let toValue: CGFloat
        switch rotationDirection {
        case .left:
            toValue = CGFloat.pi * -2.0
        case .right:
            toValue = CGFloat.pi * 2.0
        }
        
        rotateAnimation.toValue = toValue
        rotateAnimation.duration = TimeInterval(SVCRotationAnimator.duration)
        
        view.layer.add(rotateAnimation, forKey: nil)
    }
    
    open func deselect(onView view: UIView) {}
}
