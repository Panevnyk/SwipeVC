//
//  SVCFrameAnimator.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 12/18/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// SVCImagesAnimator
open class SVCImagesAnimator: SVCAnimator {
    /// duration
    public static let duration = 0.5
    
    /// images
    public let images: [CGImage]
    
    /// images
    ///
    /// - Parameter images: [CGImage]
    init(images: [CGImage]) {
        self.images = images
    }
    
    open func select(onView view: UIView) {
        let frameAnimation = CAKeyframeAnimation(keyPath: Constants.AnimationKeys.keyFrame)
        frameAnimation.calculationMode = CAAnimationCalculationMode.discrete
        frameAnimation.duration = TimeInterval(SVCImagesAnimator.duration)
        frameAnimation.values = images
        frameAnimation.repeatCount = 1
        frameAnimation.isRemovedOnCompletion = false
        frameAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        view.layer.add(frameAnimation, forKey: nil)
    }
    
    open func deselect(onView view: UIView) {}
}
