//
//  UIViewSnapshotExtension.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 8/23/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

extension UIView {
    /// Create snapshot of view
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
