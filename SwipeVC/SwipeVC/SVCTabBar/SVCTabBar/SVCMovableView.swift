//
//  SVCMovableView.swift
//  SwipeVC
//
//  Created by Panevnyk Vlad on 12/12/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit

/// SVCMovableView
open class SVCMovableView: UIView {
    
    // ---------------------------------------------------------------------
    // MARK: - Properties
    // ---------------------------------------------------------------------
    
    /// Move view
    lazy var moveView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.layer.zPosition = 11
        return view
    }()
    
    /// Move view height
    open var height: CGFloat = 1
    
    /// Move view width
    open var width: CGFloat = 0
    
    /// Attaching of move view
    open var attach: SVCMoveViewAttach = .top
    
    /// tabBarSideInnerSpace
    var tabBarSideInnerSpace: CGFloat = 0
    
    /// Bouncing of moveview
    open var bouncing: CGFloat = 0 {
        didSet {
            if bouncing > 2 {
                bouncing = 2
            } else if bouncing < 0 {
                bouncing = 0
            }
        }
    }
    
    /// backgroundColor
    open override var backgroundColor: UIColor? {
        get {
            return moveView.backgroundColor
        }
        set {
            moveView.backgroundColor = newValue
        }
    }
    
    /// left constraint
    private var cnstrMoveViewLeft: NSLayoutConstraint?
    
    /// width constraint
    private var cnstrMoveViewWidth: NSLayoutConstraint?
    
    // ---------------------------------------------------------------------
    // MARK: - Inits
    // ---------------------------------------------------------------------
    
    /// init
    ///
    /// - Parameter frame: CGRect
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    /// init
    ///
    /// - Parameter aDecoder: NSCoder
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    /// initialize
    open func initialize() {
        super.backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        layer.zPosition = 10
        isHidden = true
        addSubview(moveView)
    }
}

// MARK: - Animate MoveView
extension SVCMovableView {
    open func animateMoveView(toIndex: Int, fromIndex: Int, percent: CGFloat, isTap: Bool, duration: TimeInterval) {
        // animate move view
        guard !isHidden else { return }
        
        let magicK = CGFloat(abs(toIndex - fromIndex))
        if isTap {
            
            moveViewUpdate(proportionalLeftOffset: CGFloat(toIndex - fromIndex) / 2 + CGFloat(fromIndex))
            moveViewChangeBouncing(percent: percent / 2, magicK: magicK)
            
            UIView.animate(withDuration: duration / 2, delay: 0, options: .curveEaseIn, animations: {
                self.superview?.layoutIfNeeded()
            }, completion: { _ in
                
                self.moveViewUpdate(proportionalLeftOffset: CGFloat(toIndex))
                self.moveViewChangeBouncing(percent: percent, magicK: magicK)
                
                UIView.animate(withDuration: duration / 2, delay: 0, options: .curveEaseOut, animations: {
                    self.superview?.layoutIfNeeded()
                }, completion: nil)
            })
        } else {
            
            let leftOffset: CGFloat = fromIndex < toIndex ? CGFloat(fromIndex) + percent : CGFloat(fromIndex) - percent
            self.moveViewUpdate(proportionalLeftOffset: leftOffset)
            self.moveViewChangeBouncing(percent: percent, magicK: magicK)
            
            UIView.animate(withDuration: duration, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private func moveViewUpdate(proportionalLeftOffset: CGFloat) {
        cnstrMoveViewLeft?.constant = bounds.width * proportionalLeftOffset + tabBarSideInnerSpace
    }
    
    private func moveViewChangeBouncing(percent: CGFloat, magicK: CGFloat) {
        guard let cnstrMoveViewWidth = cnstrMoveViewWidth else { return }
        
        let newPercent = (percent < 0.5 ? percent : (1 - percent)) * 2 * magicK
        if width == 0 {
            cnstrMoveViewWidth.constant = bounds.width * newPercent * bouncing
        } else {
            cnstrMoveViewWidth.constant = width + (width * newPercent * bouncing)
        }
    }
}

// MARK: - Move methods
extension SVCMovableView {
    open func addMoveViewConstraints(to superview: UIView, itemsCount: Int) {
        guard itemsCount > 0 else { return }
        
        let allSpaces = 2 * tabBarSideInnerSpace
        
        //
        var attachConstraint: NSLayoutConstraint!
        if attach == .top {
            attachConstraint = topAnchor.constraint(equalTo: superview.topAnchor)
        } else {
            attachConstraint = superview.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
        let width = widthAnchor.constraint(equalTo: superview.widthAnchor,
                                           multiplier: 1 / CGFloat(itemsCount),
                                           constant: -allSpaces / CGFloat(itemsCount))
        let height = heightAnchor.constraint(equalToConstant: self.height)
        cnstrMoveViewLeft = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0)
        
        //
        let centerX1 = moveView.centerXAnchor.constraint(equalTo: centerXAnchor)
        let top1 = moveView.topAnchor.constraint(equalTo: topAnchor)
        let bottom1 = bottomAnchor.constraint(equalTo: moveView.bottomAnchor)
        if self.width == 0 {
            cnstrMoveViewWidth = moveView.widthAnchor.constraint(equalTo: widthAnchor)
        } else {
            cnstrMoveViewWidth = moveView.widthAnchor.constraint(equalToConstant: self.width)
        }
        
        guard let cnstrMoveViewLeft = cnstrMoveViewLeft, let cnstrMoveViewWidth = cnstrMoveViewWidth else {
            return
        }
        NSLayoutConstraint.activate([cnstrMoveViewLeft, attachConstraint, height, width, centerX1, top1, bottom1, cnstrMoveViewWidth])
    }
}
