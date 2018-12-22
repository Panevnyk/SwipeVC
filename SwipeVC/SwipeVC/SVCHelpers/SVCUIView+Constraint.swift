//
//  UIViewConstraintExtension.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 8/18/17.
//  Copyright © 2017 Vlad Panevnyk. All rights reserved.
//

import UIKit

/// Constraints
extension UIView {
    /// add simple constraints to view border
    ///
    /// - Parameter view: UIView
    /// - Returns: [NSLayoutConstraint]
    func constraint(toView view: UIView) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
    }
    
    /// add simple constraints to view border with insets
    ///
    /// - Parameters:
    ///   - view: UIView
    ///   - insets: UIEdgeInsets
    /// - Returns: [NSLayoutConstraint]
    func constraint(toView view: UIView, insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        ]
    }
}
