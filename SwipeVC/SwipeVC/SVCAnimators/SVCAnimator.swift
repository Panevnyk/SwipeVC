//
//  SVCItemAnimator.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 12/10/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// SVCAnimator
public protocol SVCAnimator {
    func select(onView view: UIView)
    func deselect(onView view: UIView)
}
