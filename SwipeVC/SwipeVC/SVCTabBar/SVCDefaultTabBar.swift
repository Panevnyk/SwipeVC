//
//  SVCDefaultTabBar.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 8/21/17.
//  Copyright © 2017 Vlad Panevnyk. All rights reserved.
//

import UIKit

/// SVCDefaultTabBar
open class SVCDefaultTabBar: UIView, SVCTabBar {
    /// Switch bar items
    public var items: [SVCTabItem] = [] {
        willSet {
            clearItems(items)
            addItems(newValue)
        }
    }
    /// SVCTabBarDelegate
    public weak var delegate: SVCTabBarDelegate?
    /// Height of switch bar
    public var height: CGFloat = 44
    /// Inner space value
    public var tabBarSideInnerSpace: CGFloat = 0
    /// Move view
    public lazy var moveView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        view.layer.zPosition = 11
        return view
    }()
    /// Move view height
    public var moveViewHeight: CGFloat = 0
    /// Bouncing of moveview
    public var bouncing: CGFloat = 0 {
        didSet {
            if bouncing > 2 {
                bouncing = 2
            } else if bouncing < 0 {
                bouncing = 0
            }
        }
    }
    /// Move view width
    public var moveViewWidth: CGFloat = 0
    /// Attaching of move view
    public var moveViewAttach: SVCMoveViewAttach = .bottom
    
    // Static variable
    /// Default switch bar height
    public static let defaultSwitchBarHeight: CGFloat = 44
    
    // Private variable
    /// view that containt moveView
    private lazy var containerMoveView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        view.layer.zPosition = 10
        return view
    }()
    
    /// left constraint
    private var cnstrMoveViewLeft: NSLayoutConstraint?
    /// width constraint
    private var cnstrMoveViewWidth: NSLayoutConstraint?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initializer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializer()
    }
    
    private func initializer() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerMoveView)
        containerMoveView.addSubview(moveView)
    }
    
    /// move
    ///
    /// - Parameters:
    ///   - toIndex: Int
    ///   - fromIndex: Int
    ///   - percent: percent of change
    ///   - isTap: is method called after tap to item
    ///   - duration: duration for animation change
    public func move(toIndex: Int, fromIndex: Int, percent: CGFloat, isTap: Bool, duration: TimeInterval) {
        
        // animate move view
        if !moveView.isHidden {
            let magicK = CGFloat(abs(toIndex - fromIndex))
            if isTap {
                
                moveViewUpdate(proportionalLeftOffset: CGFloat(toIndex - fromIndex) / 2 + CGFloat(fromIndex))
                moveViewChangeBouncing(percent: percent / 2, magicK: magicK)
                
                UIView.animate(withDuration: duration / 2, delay: 0, options: .curveEaseIn, animations: {
                    self.layoutIfNeeded()
                }, completion: { _ in
                    
                    self.moveViewUpdate(proportionalLeftOffset: CGFloat(toIndex))
                    self.moveViewChangeBouncing(percent: percent, magicK: magicK)
                    
                    UIView.animate(withDuration: duration / 2, delay: 0, options: .curveEaseOut, animations: {
                        self.layoutIfNeeded()
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
    }
}

// MARK: - Actions
extension SVCDefaultTabBar {
    @objc private func itemTap(_ sender: UIButton) {
        let index = sender.tag
        delegate?.select(item: index)
    }
}

// MARK: - Move methods
private extension SVCDefaultTabBar {
    func moveViewUpdate(proportionalLeftOffset: CGFloat) {
        cnstrMoveViewLeft?.constant = containerMoveView.bounds.width * proportionalLeftOffset + tabBarSideInnerSpace
    }
    
    func moveViewChangeBouncing(percent: CGFloat, magicK: CGFloat) {
        
        if let cnstrMoveViewWidth = cnstrMoveViewWidth {
            let newPercent = (percent < 0.5 ? percent : (1 - percent)) * 2 * magicK
            
            if moveViewWidth == 0 {
                cnstrMoveViewWidth.constant = containerMoveView.frame.width * newPercent * bouncing
            } else {
                cnstrMoveViewWidth.constant = moveViewWidth + (moveViewWidth * newPercent * bouncing)
            }
        }
    }
}

// MARK: - Constraints
private extension SVCDefaultTabBar {
    func clearItems(_ items: [SVCTabItem]) {
        items.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func addItems(_ items: [SVCTabItem]) {
        let allSpaces = 2 * tabBarSideInnerSpace
        
        for (i, item) in items.enumerated() {
            item.tag = i
            item.addTarget(self, action: #selector(itemTap), for: .touchUpInside)
            item.translatesAutoresizingMaskIntoConstraints = false
            addSubview(item)
      
            NSLayoutConstraint.activate([item.leadingAnchor.constraint(equalTo: i == 0 ? leadingAnchor : items[i - 1].trailingAnchor,
                                                                       constant: i == 0 ? tabBarSideInnerSpace : 0),
                                         item.topAnchor.constraint(equalTo: topAnchor),
                                         item.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / CGFloat(items.count),
                                                                     constant: -allSpaces / CGFloat(items.count)),
                                         bottomAnchor.constraint(equalTo: item.bottomAnchor)])
        }
        
        addMoveViewConstraints(itemsCount: items.count)
    }
    
    func addMoveViewConstraints(itemsCount: Int) {
        if itemsCount == 0 {
            return
        }
        
        let allSpaces = 2 * tabBarSideInnerSpace
        
        ///
        var attachConstraint: NSLayoutConstraint!
        if moveViewAttach == .top {
            attachConstraint = containerMoveView.topAnchor.constraint(equalTo: topAnchor)
        } else {
            attachConstraint = bottomAnchor.constraint(equalTo: containerMoveView.bottomAnchor)
        }
        let width = containerMoveView.widthAnchor.constraint(equalTo: widthAnchor,
                                                             multiplier: 1 / CGFloat(itemsCount),
                                                             constant: -allSpaces / CGFloat(itemsCount))
        let height = containerMoveView.heightAnchor.constraint(equalToConstant: moveViewHeight)
        cnstrMoveViewLeft = containerMoveView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        
        ///
        let centerX1 = moveView.centerXAnchor.constraint(equalTo: containerMoveView.centerXAnchor)
        let top1 = moveView.topAnchor.constraint(equalTo: containerMoveView.topAnchor)
        let bottom1 = containerMoveView.bottomAnchor.constraint(equalTo: moveView.bottomAnchor)
        if moveViewWidth == 0 {
            cnstrMoveViewWidth = moveView.widthAnchor.constraint(equalTo: containerMoveView.widthAnchor)
        } else {
            cnstrMoveViewWidth = moveView.widthAnchor.constraint(equalToConstant: moveViewWidth)
        }
        
        guard let cnstrMoveViewLeft = cnstrMoveViewLeft, let cnstrMoveViewWidth = cnstrMoveViewWidth else {
            return
        }
        NSLayoutConstraint.activate([cnstrMoveViewLeft, attachConstraint, height, width, centerX1, top1, bottom1, cnstrMoveViewWidth])
    }
}
