//
//  SVCInterpolateHelper.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 1/16/17.
//  Copyright © 2017 Vlad Panevnyk. All rights reserved.
//

import UIKit

/// SVCInterpolateHelper
public final class SVCInterpolateHelper {
    /// getPointBy
    ///
    /// - Parameters:
    ///   - xPoint: current xPoint
    ///   - curve: UIViewAnimationCurve
    /// - Returns: new xPoint by UIViewAnimationCurve
    public static func getPointBy(xPoint: CGFloat, curve: UIView.AnimationCurve) -> CGFloat {
        return getPointBy(xPoint: xPoint, factor: 1.0, curve: curve)
    }
    
    /// getPointBy
    ///
    /// - Parameters:
    ///   - xPoint: current xPoint
    ///   - factor: pow factor
    ///   - curve: UIViewAnimationCurve
    /// - Returns: new xPoint by UIViewAnimationCurve
    public static func getPointBy(xPoint: CGFloat, factor: CGFloat, curve: UIView.AnimationCurve) -> CGFloat {
        switch curve {
        case .easeIn:
            return pow(xPoint, 2 * factor)
        case .easeOut:
            return (1.0 - pow((1.0 - xPoint), 2 * factor))
        case .easeInOut:
            return (cos((xPoint + 1) * CGFloat(Double.pi)) / 2.0) + 0.5
        case .linear:
            return xPoint
        }
    }
}
