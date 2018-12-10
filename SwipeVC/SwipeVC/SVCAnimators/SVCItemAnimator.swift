//
//  SVCItemAnimator.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 12/10/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// SVCItemAnimator
public protocol SVCItemAnimator {
//    updateStyle(toIndex: Int, fromIndex: Int, percent: CGFloat, isTap: Bool, duration: TimeInterval)
    func animate(imageView: UIImageView, label: UILabel, percent: CGFloat, isTap: Bool, duration: TimeInterval)
}
