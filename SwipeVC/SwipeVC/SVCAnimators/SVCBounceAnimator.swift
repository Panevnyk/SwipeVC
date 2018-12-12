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
    /// duration
    public static let duration = 0.25
    
    open func select(onView view: UIView) {
        let bounceAnimation = CAKeyframeAnimation(keyPath: Constants.AnimationKeys.scale)
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(SVCBounceAnimator.duration)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        
        view.layer.add(bounceAnimation, forKey: nil)
    }
    
    open func deselect(onView view: UIView) {}
}
