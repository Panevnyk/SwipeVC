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
    /// frameAnimation
    public let frameAnimation = CAKeyframeAnimation(keyPath: Constants.AnimationKeys.keyFrame)
    
    /// images
    public let images: [CGImage]
    
    /// duration
    open var duration: TimeInterval = 0.5
    
    /// calculationMode
    open var calculationMode = CAAnimationCalculationMode.discrete
    
    /// fillMode
    open var fillMode = CAMediaTimingFillMode.forwards
    
    /// images
    ///
    /// - Parameter images: [CGImage]
    public init(images: [CGImage]) {
        self.images = images
    }
    
    /// select onView method describe selection view animation
    ///
    /// - Parameter view: View that will be animated
    open func select(onView view: UIView) {
        frameAnimation.calculationMode = calculationMode
        frameAnimation.duration = duration
        frameAnimation.values = images
        frameAnimation.repeatCount = 1
        frameAnimation.isRemovedOnCompletion = false
        frameAnimation.fillMode = fillMode
        
        view.layer.add(frameAnimation, forKey: nil)
    }
    
    /// deselect onView method describe deselection view animation
    ///
    /// - Parameter view: View that will be animated
    open func deselect(onView view: UIView) {}
}
