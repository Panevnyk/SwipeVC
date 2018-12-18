//
//  SVCFrameAnimator.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 12/18/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// SVCValuesAnimator
open class SVCValuesAnimator: SVCAnimator {
    /// duration
    public static let duration = 0.5
    
    /// values
    public let values: [Any]
    
    /// values
    ///
    /// - Parameter values: [Any]
    init(values: [Any]) {
        self.values = values
    }
    
    open func select(onView view: UIView) {
        let frameAnimation = CAKeyframeAnimation(keyPath: Constants.AnimationKeys.keyFrame)
        frameAnimation.calculationMode = CAAnimationCalculationMode.discrete
        frameAnimation.duration = TimeInterval(SVCValuesAnimator.duration)
        frameAnimation.values = values
        frameAnimation.repeatCount = 1
        frameAnimation.isRemovedOnCompletion = false
        frameAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        view.layer.add(frameAnimation, forKey: nil)
    }
    
    open func deselect(onView view: UIView) {}
}
