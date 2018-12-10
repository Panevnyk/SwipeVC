//
//  SVCUIColor+CombineColor.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 9/12/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// CombineColor(
extension UIColor {
    /// getCombineColor
    ///
    /// - Parameters:
    ///   - percent: CGFloat, from 0 to 1
    ///   - toColor: UIColor
    /// - Returns: UIColor
    public func getCombineColor(percent: CGFloat, toColor: UIColor) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        var toRed: CGFloat = 0
        var toGreen: CGFloat = 0
        var toBlue: CGFloat = 0
        var toAlpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        
        var newRed: CGFloat = 0
        var newGreen: CGFloat = 0
        var newBlue: CGFloat = 0
        var newAlpha: CGFloat = 0
        
        let deltaRed = toRed - red
        newRed = red + (deltaRed * percent)
        
        let deltaGreen = toGreen - green
        newGreen = green + (deltaGreen * percent)
        
        let deltaBlue = toBlue - blue
        newBlue = blue + (deltaBlue * percent)
        
        let deltaAlpha = toAlpha - alpha
        newAlpha = alpha + (deltaAlpha * percent)
        
        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
    }
}
