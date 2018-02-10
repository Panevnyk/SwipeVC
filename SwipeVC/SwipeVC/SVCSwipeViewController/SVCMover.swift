//
//  SVCMover.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 9/6/17.
//  Copyright © 2017 Vlad Panevnyk. All rights reserved.
//

import Foundation

final class SVCMover {
    private var movingCounter = 0
    var isMoving: Bool {
        return movingCounter > 0
    }
    
    @discardableResult
    func move(_ move: Bool) -> Bool {
        movingCounter += move ? 1 : -1
        return isMoving
    }
}
