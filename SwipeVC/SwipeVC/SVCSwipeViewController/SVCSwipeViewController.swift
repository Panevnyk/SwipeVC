//
//  SVCSwipeViewController.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Vlad Panevnyk on 18.04.16.
//  Copyright © 2016 Vlad Panevnyk. All rights reserved.
//

import UIKit

/// SVCSwipeViewController
open class SVCSwipeViewController: UIViewController {
    /// BG view items top space
    public static let defaultNavigationBGViewForItemsTopSpace: CGFloat = 20
    
    // Public variable
    /// SVCNavigationBar, for add need injection
    public var navigationBar: (SVCNavigationBar & UIView)? {
        willSet {
            if let navigationBar = navigationBar {
                navigationBar.removeFromSuperview()
            }
        }
        didSet {
            addNavigationBar()
            updateSwitchContentTopAnchor()
        }
    }
    /// SVCTabBar, for add need injection
    public var tabBar: (SVCTabBar & UIView)? {
        willSet {
            tabBar?.removeFromSuperview()
            tabBarBottomView?.removeFromSuperview()
        }
        didSet {
            addTabBar()
        }
    }
    /// ViewControllers that will be manage
    public var viewControllers: [UIViewController] = [] {
        didSet {
            if isViewLoaded {
                updateContainerForViewController()
                addViewController(index: selectedItem)
            }
        }
    }
    /// SwitchBarType for attaching
    public var tabBarType: SVCTabBarType = .bottom {
        didSet {
            updateSwitchBarTopOrBottomAnchor()
            switch tabBarType {
            case .top:
                tabBarBottomView?.removeFromSuperview()
            case .bottom:
                addTabBarBottomView()
            }
        }
    }
    /// Insets of all content (including SwitchBar and ViewControllers)
    public var contentInsets = UIEdgeInsets.zero {
        didSet {
            if isViewLoaded {
                cnstrTopSwipeContent.constant = contentInsets.top
                cnstrBottomSwipeContent.constant = contentInsets.bottom
                cnstrLeftSwipeContent.constant = contentInsets.left
                cnstrRightSwipeContent.constant = contentInsets.right
                updateScrollViewOffset(animated: true)
                view.layoutIfNeeded()
            }
        }
    }
    /// Insets of SwitchBar
    public var tabBarInsets = UIEdgeInsets.zero {
        didSet {
            if isViewLoaded {
                switch tabBarType {
                case .bottom:
                    cnstrLeftTabBar.constant = tabBarInsets.left
                    cnstrRightTabBar.constant = tabBarInsets.right
                    cnstrTopOrBottomTabBar.constant = tabBarInsets.bottom
                case .top:
                    cnstrLeftTabBar.constant = tabBarInsets.left
                    cnstrTopOrBottomTabBar.constant = tabBarInsets.top
                    cnstrRightTabBar.constant = tabBarInsets.right
                }
                containerView.layoutIfNeeded()
            }
        }
    }
    /// Insets of ViewControllers
    public var viewControllersInsets = UIEdgeInsets.zero {
        didSet {
            if isViewLoaded {
                switch tabBarType {
                case .bottom:
                    cnstrLeftScrollView.constant = viewControllersInsets.left
                    cnstrTopScrollView.constant = viewControllersInsets.top
                    cnstrRightScrollView.constant = viewControllersInsets.right
                    cnstrBottomScrollView.constant = (tabBar?.height ?? 0) + viewControllersInsets.bottom
                case .top:
                    cnstrLeftScrollView.constant = viewControllersInsets.left
                    cnstrTopScrollView.constant = (tabBar?.height ?? 0) + viewControllersInsets.top
                    cnstrRightScrollView.constant = viewControllersInsets.right
                    cnstrBottomScrollView.constant = viewControllersInsets.bottom
                }
                containerView.layoutIfNeeded()
            }
        }
    }
    /// scrollViewBounces
    public var scrollViewBounces: Bool = false {
        didSet {
            scrollView.bounces = scrollViewBounces
        }
    }
    
    /// isTabBarBottomViewShow
    public var isTabBarBottomViewShow = true {
        didSet {
            if isViewLoaded {
                addTabBarBottomView()
            }
        }
    }

    // Internal variable
    var tabBarBottomView: UIView?
    
    lazy var swipeContent: UIView = {
        let swipeContent = UIView()
        swipeContent.backgroundColor = UIColor.clear
        swipeContent.translatesAutoresizingMaskIntoConstraints = false
        return swipeContent
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.clear
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    var isShowViewControllers: [Int: Bool] = [:]
    
    var viewsBG: [UIView] = []
    var snapShots: [Int: UIImageView] = [:]
    let mover = SVCMover()
    var scrolling = false
    
    var isViewReadyForUpdate = false
    var isViewWillAppear = false
    
    var cnstrConteinerViewWidth: NSLayoutConstraint?
    
    var selectedItem = 0 {
        willSet {
            previousSelectedItem = selectedItem
        }
    }
    var previousSelectedItem = 0
    
    // Static variable
    static let moveVCDuration: TimeInterval = 0.3
    static let moveVCDelay: TimeInterval = 0
    static let moveVCAnimationOption = UIView.AnimationOptions.curveEaseInOut

    // Constraints
    ///      For content insets
    var cnstrTopSwipeContent: NSLayoutConstraint!
    var cnstrBottomSwipeContent: NSLayoutConstraint!
    var cnstrLeftSwipeContent: NSLayoutConstraint!
    var cnstrRightSwipeContent: NSLayoutConstraint!
    ///      For tabBar insets
    var cnstrTopOrBottomTabBar: NSLayoutConstraint!
    var cnstrLeftTabBar: NSLayoutConstraint!
    var cnstrRightTabBar: NSLayoutConstraint!
    var cnstrHeightTabBar: NSLayoutConstraint!
    ///      For scroll insets
    var cnstrTopScrollView: NSLayoutConstraint!
    var cnstrLeftScrollView: NSLayoutConstraint!
    var cnstrRightScrollView: NSLayoutConstraint!
    var cnstrBottomScrollView: NSLayoutConstraint!
}

// MARK: - Life circle methods
extension SVCSwipeViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard !isViewWillAppear else {
            return
        }
        
        update(selectedItem: selectedItem, animated: false)
        isViewWillAppear = true
    }
}

// MARK: - Settings (Public methods)
extension SVCSwipeViewController: SVCTabBarDelegate {
    /// select
    ///
    /// - Parameter item: for selection
    /// - Returns: did item select
    @discardableResult
    public func select(item: Int) -> Bool {
        guard selectedItem != item else {
            return false
        }
        return setSelectedItem(item, animated: true)
    }
    
    /// setSelectedItem
    ///
    /// - Parameters:
    ///   - item: for selection
    ///   - animated: is animated
    /// - Returns: did item select
    @discardableResult
    public func setSelectedItem(_ item: Int, animated: Bool) -> Bool {
        if isViewWillAppear {
            return update(selectedItem: item, animated: animated)
        }
        selectedItem = item
        return true
    }
    
    /// update UI by selected item
    ///
    /// - Parameters:
    ///   - item: selected item
    ///   - animated: is animated update UI
    /// - Returns: did UI update
    @discardableResult
    public func update(selectedItem item: Int, animated: Bool) -> Bool {
        guard item > -1 && item < viewControllers.count else {
            return false
        }
        
        selectedItem = item
        let duration = animated ? SVCSwipeViewController.moveVCDuration : 0.0
        
        moveNavigationBar(toItem: selectedItem, fromItem: previousSelectedItem, percent: 1, duration: duration)
        moveTabBar(toItem: selectedItem, fromItem: previousSelectedItem, percent: 1, duration: duration, isTap: true)
        moveScrollView(toItem: selectedItem, fromItem: previousSelectedItem, duration: duration)
        
        return true
    }
}
