//
//  SVCSwipeViewControllerExtension.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 9/6/17.
//  Copyright © 2017 Vlad Panevnyk. All rights reserved.
//

import UIKit

// MARK: - UI
extension SVCSwipeViewController {
    /// createUI
    func createUI() {
        isViewReadyForUpdate = true
        
        automaticallyAdjustsScrollViewInsets = false
        
        addSwitchContent()
        addScrollView()
        addConteinerView()
        addTabBar()
        
        view.layoutIfNeeded()
    }
    
    /// addSwitchContent
    func addSwitchContent() {
        view.addSubview(swipeContent)
        
        cnstrLeftSwipeContent = swipeContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentInsets.left)
        if cnstrTopSwipeContent == nil {
            updateSwitchContentTopAnchor()
        }
        cnstrRightSwipeContent = view.trailingAnchor.constraint(equalTo: swipeContent.trailingAnchor, constant: contentInsets.right)
        if #available(iOS 11.0, *) {
            cnstrBottomSwipeContent = view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: swipeContent.bottomAnchor,
                                                                                       constant: contentInsets.bottom)
        } else {
            cnstrBottomSwipeContent = bottomLayoutGuide.topAnchor.constraint(equalTo: swipeContent.bottomAnchor,
                                                                             constant: contentInsets.bottom)
        }
        
        NSLayoutConstraint.activate([cnstrRightSwipeContent, cnstrBottomSwipeContent, cnstrTopSwipeContent, cnstrLeftSwipeContent])
    }
    
    /// updateSwitchContentTopAnchor
    func updateSwitchContentTopAnchor() {
        guard isViewReadyForUpdate else {
            return
        }
        
        if let cnstrTopSwipeContent = cnstrTopSwipeContent {
            NSLayoutConstraint.deactivate([cnstrTopSwipeContent])
        }
        
        if #available(iOS 11.0, *) {
            cnstrTopSwipeContent = swipeContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                                     constant: contentInsets.top)
        } else {
            cnstrTopSwipeContent = swipeContent.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,
                                                                     constant: contentInsets.top)
        }
        
        NSLayoutConstraint.activate([cnstrTopSwipeContent])
    }
    
    /// addScrollView
    func addScrollView() {
        guard isViewReadyForUpdate else {
            return
        }
        swipeContent.addSubview(scrollView)
        
        cnstrLeftScrollView = scrollView.leadingAnchor.constraint(equalTo: swipeContent.leadingAnchor,
                                                                  constant: viewControllersInsets.left)
        cnstrRightScrollView = swipeContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,
                                                                      constant: viewControllersInsets.right)
        switch tabBarType {
        case .bottom:
            cnstrTopScrollView = scrollView.topAnchor.constraint(equalTo: swipeContent.topAnchor,
                                                                 constant: viewControllersInsets.top)
            cnstrBottomScrollView = swipeContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,
                                                                         constant: (tabBar?.height ?? 0) + viewControllersInsets.bottom)
        case .top:
            cnstrTopScrollView = scrollView.topAnchor.constraint(equalTo: swipeContent.topAnchor,
                                                                 constant: (tabBar?.height ?? 0) + viewControllersInsets.top)
            cnstrBottomScrollView = swipeContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,
                                                                         constant: viewControllersInsets.bottom)
        }
        
        NSLayoutConstraint.activate([cnstrTopScrollView, cnstrRightScrollView, cnstrBottomScrollView, cnstrLeftScrollView])
    }
    
    /// addConteinerView
    func addConteinerView() {
        guard isViewReadyForUpdate else {
            return
        }
        scrollView.addSubview(containerView)
        
        var cnstrs = containerView.constraint(toView: scrollView)
        cnstrs.append(containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor))
        
        NSLayoutConstraint.activate(cnstrs)
        
        updateContainerForViewController()
    }
    
    /// addTabBar
    func addTabBar() {
        guard isViewReadyForUpdate else {
            return
        }
        guard let tabBar = tabBar else {
            return
        }
        
        tabBar.delegate = self
        let height = tabBar.height
        
        swipeContent.addSubview(tabBar)
        
        cnstrLeftTabBar = tabBar.leadingAnchor.constraint(equalTo: swipeContent.leadingAnchor, constant: tabBarInsets.left)
        cnstrRightTabBar = swipeContent.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: tabBarInsets.right)
        cnstrHeightTabBar = tabBar.heightAnchor.constraint(equalToConstant: height)
        updateSwitchBarTopOrBottomAnchor()
        
        NSLayoutConstraint.activate([cnstrHeightTabBar, cnstrTopOrBottomTabBar, cnstrRightTabBar, cnstrLeftTabBar])
        
        // addTabBarBottomView
        addTabBarBottomView()
        
        // addTabBarTopView
        addTabBarTopView()
    }
    
    /// updateSwitchBarTopOrBottomAnchor
    func updateSwitchBarTopOrBottomAnchor() {
        guard isViewReadyForUpdate else {
            return
        }
        guard let tabBar = tabBar else {
            return
        }
        
        if let cnstrTopOrBottomTabBar = cnstrTopOrBottomTabBar {
            NSLayoutConstraint.deactivate([cnstrTopOrBottomTabBar])
        }
        
        switch tabBarType {
        case .bottom:
            cnstrTopOrBottomTabBar = swipeContent.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor,
                                                                          constant: tabBarInsets.bottom)
        case .top:
            cnstrTopOrBottomTabBar = tabBar.topAnchor.constraint(equalTo: swipeContent.topAnchor,
                                                                 constant: tabBarInsets.top)
        }
        
        NSLayoutConstraint.activate([cnstrTopOrBottomTabBar])
    }
    
    /// addTabBarBottomView
    func addTabBarBottomView() {
        guard isTabBarBottomViewShow else {
            return
        }
        guard tabBarBottomView == nil else {
            return
        }
        guard let tabBar = tabBar else {
            return
        }
        guard tabBarType == .bottom else {
            return
        }
        
        if #available(iOS 11.0, *) {
            tabBarBottomView = UIView()
            tabBarBottomView?.translatesAutoresizingMaskIntoConstraints = false
            tabBarBottomView?.backgroundColor = tabBar.backgroundColor
            
            if let tabBarBottomView = tabBarBottomView {
                view.addSubview(tabBarBottomView)
                NSLayoutConstraint.activate([
                    tabBarBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: tabBarBottomView.trailingAnchor),
                    view.bottomAnchor.constraint(equalTo: tabBarBottomView.bottomAnchor),
                    tabBarBottomView.topAnchor.constraint(equalTo: tabBar.bottomAnchor)
                    ])
            }
        }
    }
    
    /// addTabBarTopView
    func addTabBarTopView() {
        guard isTabBarTopViewShow else {
            return
        }
        guard tabBarTopView == nil else {
            return
        }
        guard let tabBar = tabBar else {
            return
        }
        guard tabBarType == .top else {
            return
        }
        
        if #available(iOS 11.0, *) {
            tabBarTopView = UIView()
            tabBarTopView?.translatesAutoresizingMaskIntoConstraints = false
            tabBarTopView?.backgroundColor = tabBar.backgroundColor
            
            if let tabBarTopView = tabBarTopView {
                view.addSubview(tabBarTopView)
                NSLayoutConstraint.activate([
                    tabBarTopView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: tabBarTopView.trailingAnchor),
                    view.topAnchor.constraint(equalTo: tabBarTopView.topAnchor),
                    tabBarTopView.bottomAnchor.constraint(equalTo: tabBar.topAnchor)
                    ])
            }
        }
    }
    
    /// updateContainerForViewController
    func updateContainerForViewController() {
        guard isViewReadyForUpdate else {
            return
        }
        
        let widthMultiplier = viewControllers.count > 0 ? viewControllers.count : 1
        
        // Add width constraint to container
        if let cnstrConteinerViewWidth = cnstrConteinerViewWidth {
            scrollView.removeConstraint(cnstrConteinerViewWidth)
        }
        cnstrConteinerViewWidth = containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                                                       multiplier: CGFloat(widthMultiplier))
        if let cnstrConteinerViewWidth = cnstrConteinerViewWidth {
            scrollView.addConstraint(cnstrConteinerViewWidth)
        }
        
        // Clear views BG
        clearViewsBG()
        
        // Create containerForViewController views
        for i in 0 ..< viewControllers.count {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(v)
            
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: i == 0
                    ? containerView.leadingAnchor
                    : viewsBG[i - 1].trailingAnchor),
                v.topAnchor.constraint(equalTo: containerView.topAnchor),
                v.widthAnchor.constraint(equalTo: containerView.widthAnchor,
                                         multiplier: 1.0 / CGFloat(widthMultiplier)),
                v.heightAnchor.constraint(equalTo: containerView.heightAnchor)])
            viewsBG.append(v)
        }
    }
    
    /// clearViewsBG
    func clearViewsBG() {
        viewsBG.forEach {
            $0.removeFromSuperview()
        }
        viewsBG.removeAll()
    }
}

// MARK: - work with scroll view offset
extension SVCSwipeViewController {
    /// updateScrollViewOffset
    ///
    /// - Parameter animated: Bool, default value - false
    func updateScrollViewOffset(animated: Bool = false) {
        updateScrollViewOffset(contentWidth: view.frame.width, animated: animated)
    }
    
    /// updateScrollViewOffset
    ///
    /// - Parameters:
    ///   - contentWidth: contentWidth descriptionCGFloat
    ///   - animated: Bool, default value - false
    func updateScrollViewOffset(contentWidth: CGFloat, animated: Bool = false) {
        scrollView.setContentOffset(CGPoint(x: contentWidth * CGFloat(selectedItem), y: 0), animated: animated)
    }
}

// MARK: - Move element
extension SVCSwipeViewController {
    /// move tab bar
    ///
    /// - Parameters:
    ///   - toItem: Int
    ///   - fromItem: Int
    ///   - percent: CGFloat, percent of change from 0 to 1
    ///   - duration: TimeInterval
    ///   - isTap: Bool, tap to item or swipe scroll
    func moveTabBar(toItem: Int, fromItem: Int, percent: CGFloat, duration: TimeInterval, isTap: Bool) {
        tabBar?.move(toIndex: toItem,
                     fromIndex: fromItem,
                     percent: percent,
                     isTap: isTap,
                     duration: duration)
    }
    
    /// Move scroll view between special items
    ///
    /// - Parameters:
    ///   - toItem: Int
    ///   - fromItem: Int
    ///   - duration: TimeInterval
    func moveScrollView(toItem: Int, fromItem: Int, duration: TimeInterval) {
        mover.move(true)
        addViewController(index: toItem)
        
        if duration == 0.0 {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.width * CGFloat(toItem), y: 0)
            mover.move(false)
        } else {
            
            addViewControllers(fromIndex: fromItem, toIndex: toItem)
            
            UIView.animate(withDuration: duration,
                           delay: SVCSwipeViewController.moveVCDelay,
                           options: SVCSwipeViewController.moveVCAnimationOption,
                           animations: { [unowned self] in
                            
                            self.scrollView.contentOffset = CGPoint(x: self.scrollView.bounds.width * CGFloat(toItem), y: 0)
                }, completion: { [weak self] _ in
                    
                    self?.mover.move(false)
                    self?.removeAllViewControllersWithoutSelected()
            })
            
        }
    }
}

// MARK: - Work with ViewController
extension SVCSwipeViewController {
    /// addControllers between indexes
    ///
    /// - Parameters:
    ///   - fromIndex: Int
    ///   - toIndex: Int
    func addViewControllers(fromIndex: Int, toIndex: Int) {
        guard fromIndex != toIndex else {
            return
        }
        
        for i in min(fromIndex, toIndex) + 1 ..< max(fromIndex, toIndex) {
            addViewController(index: i)
        }
    }
    
    /// removeControllers between indexes
    ///
    /// - Parameters:
    ///   - fromIndex: Int
    ///   - toIndex: Int
    func removeControllers(fromIndex: Int, toIndex: Int) {
        guard fromIndex != toIndex else {
            return
        }
        
        for i in min(fromIndex, toIndex) + 1 ..< max(fromIndex, toIndex) {
            removeViewController(index: i)
        }
    }
    
    /// removeAllViewControllersWithoutSelected
    func removeAllViewControllersWithoutSelected() {
        guard !mover.isMoving else {
            return
        }
        
        for i in 0 ..< viewControllers.count where i != selectedItem {
            removeViewController(index: i)
        }
    }
    
    /// Add view controller to special index
    ///
    /// - Parameter index: Int
    func addViewController(index: Int) {
        guard index < viewControllers.count else {
            return
        }
        
        if viewControllers[index].view.superview != nil {
            removeViewController(index: index)
        }
        
        isShowViewControllers[index] = true
        let viewController = viewControllers[index]
        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewsBG[index].addSubview(viewController.view)
        NSLayoutConstraint.activate(viewController.view.constraint(toView: viewsBG[index]))
        didMove(toParent: self)
    }
    
    /// Remove view controller from special index
    ///
    /// - Parameter index: Int
    func removeViewController(index: Int) {
        guard isShowViewControllers[index] ?? false else {
            return
        }
        guard viewControllers[index].view.superview != nil else {
            return
        }
        
        isShowViewControllers[index] = false
        willMove(toParent: nil)
        viewControllers[index].view.removeFromSuperview()
        viewControllers[index].removeFromParent()
    }
}

// MARK: - UIScrollViewDelegate
extension SVCSwipeViewController: UIScrollViewDelegate {
    /// scrollViewDidScroll
    ///
    /// - Parameter scrollView: that was scroll
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !mover.isMoving else {
            return
        }
        
        let offsetPercent = scrollView.contentOffset.x / scrollView.bounds.width
        var percent = CGFloat(selectedItem) - offsetPercent
        let toItem = percent > 0 ? selectedItem - 1 : selectedItem + 1
        percent = abs(percent)
        if percent > 1 { percent = 1 }
        
        guard toItem > -1 && toItem < viewControllers.count else {
            return
        }
        
        if viewControllers[toItem].view.superview == nil {
            addViewController(index: toItem)
        }
        moveTabBar(toItem: toItem,
                   fromItem: selectedItem,
                   percent: percent,
                   duration: 0.01,
                   isTap: false)
        if percent == 1 {
            selectedItem = toItem
        }
    }
    
    /// scrollViewDidEndDecelerating
    ///
    /// - Parameter scrollView: that was scroll
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        removeAllViewControllersWithoutSelected()
    }
}

// MARK: - Handle device orientation
extension SVCSwipeViewController {
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        mover.move(true)
        coordinator.animate(alongsideTransition: { [unowned self] _ -> Void in
            self.updateScrollViewOffset(contentWidth: size.width)
            
            self.moveTabBar(toItem: self.selectedItem,
                            fromItem: self.previousSelectedItem,
                            percent: 1,
                            duration: 0,
                            isTap: false)
            }, completion: { [unowned self] _ -> Void in
                self.mover.move(false)
        })
    }
}
