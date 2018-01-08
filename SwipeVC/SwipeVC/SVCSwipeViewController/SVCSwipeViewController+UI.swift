//
//  SVCSwipeViewControllerExtension.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 9/6/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
  
// MARK: - UI
extension SVCSwipeViewController {
    // Create and update UI
    func createUI() {
        isViewReadyForUpdate = true
        
        automaticallyAdjustsScrollViewInsets = false
        
        addNavigationBar()
        addSwitchContent()
        addScrollView()
        addConteinerView()
        addSwitchBar()
        
        view.layoutIfNeeded()
    }
    
    // SVCNavigationBar
    func addNavigationBar() {
        guard isViewReadyForUpdate else {
            return
        }
        guard let navigationBar = navigationBar else {
            return
        }
        
        view.addSubview(navigationBar)
        
        let topConstraint: NSLayoutConstraint
        if #available(iOS 11.0, *) {
            topConstraint = navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                               constant: -UIApplication.shared.statusBarFrame.height)
        } else {
            topConstraint = navigationBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,
                                                               constant: -UIApplication.shared.statusBarFrame.height)
        }
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topConstraint
            ])
    }
    
    // SwitchContent
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
    
    func updateSwitchContentTopAnchor() {
        guard isViewReadyForUpdate else {
            return
        }
        
        if let cnstrTopSwipeContent = cnstrTopSwipeContent {
            NSLayoutConstraint.deactivate([cnstrTopSwipeContent])
        }
        
        if let navigationBar = navigationBar {
            cnstrTopSwipeContent = swipeContent.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: contentInsets.top)
        } else {
            if #available(iOS 11.0, *) {
                cnstrTopSwipeContent = swipeContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                                        constant: contentInsets.top)
            } else {
                cnstrTopSwipeContent = swipeContent.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,
                                                                        constant: contentInsets.top)
            }
        }
        
        NSLayoutConstraint.activate([cnstrTopSwipeContent])
    }
    
    // ScrollView
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
    
    // ContainerView
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
    
    // SwitchBar
    func addSwitchBar() {
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
    }
    
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
    
    // ConteinerView
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
            
            NSLayoutConstraint.activate([v.leadingAnchor.constraint(equalTo: i == 0 ?
                containerView.leadingAnchor :
                viewsBG[i - 1].trailingAnchor),
                                         v.topAnchor.constraint(equalTo: containerView.topAnchor),
                                         v.widthAnchor.constraint(equalTo: containerView.widthAnchor,
                                                                  multiplier: 1.0 / CGFloat(widthMultiplier)),
                                         v.heightAnchor.constraint(equalTo: containerView.heightAnchor)])
            viewsBG.append(v)
        }
    }
    
    func clearViewsBG() {
        viewsBG.forEach {
            $0.removeFromSuperview()
        }
        viewsBG.removeAll()
    }
    
    func addSnapshot(index: Int, snapshot: UIView) {
        guard snapshot.superview == nil else {
            return
        }
        
        snapshot.translatesAutoresizingMaskIntoConstraints = false
        viewsBG[index].addSubview(snapshot)
        NSLayoutConstraint.activate(snapshot.constraint(toView: viewsBG[index]))
    }
    
    func addViewController(index: Int) {
        guard index < viewControllers.count else {
            return
        }
        
        if viewControllers[index].view.superview != nil {
            removeViewController(index: index)
        }
        
        isShowViewControllers[index] = true
        let viewController = viewControllers[index]
        addChildViewController(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewsBG[index].addSubview(viewController.view)
        NSLayoutConstraint.activate(viewController.view.constraint(toView: viewsBG[index]))
        didMove(toParentViewController: self)
        
        createSnapshot(index: index)
    }
    
    func removeViewController(index: Int) {
        guard isShowViewControllers[index] ?? false else {
            return
        }
        guard viewControllers[index].view.superview != nil else {
            return
        }
        
        isShowViewControllers[index] = false
        willMove(toParentViewController: nil)
        viewControllers[index].view.removeFromSuperview()
        viewControllers[index].removeFromParentViewController()
    }
    
    func removeSnapshot(index: Int) {
        guard snapShots[index]?.superview != nil else {
            return
        }
        guard !mover.isMoving else {
            return
        }
        
        snapShots[index]?.removeFromSuperview()
    }
    
    func updateScrollViewOffset(animated: Bool = false) {
        updateScrollViewOffset(contentWidth: view.frame.width, animated: animated)
    }
    
    func updateScrollViewOffset(contentWidth: CGFloat, animated: Bool = false) {
        scrollView.setContentOffset(CGPoint(x: contentWidth * CGFloat(selectedItem), y: 0), animated: animated)
    }
    
    func createSnapshot(index: Int) {
        guard isViewWillAppear else {
            return
        }
        guard viewControllers[index].view.superview != nil else {
            return
        }
        
        // Fix bug create more snapshots than needed
        if snapShots[selectedItem]?.superview != nil {
            snapShots[selectedItem]?.removeFromSuperview()
        }
        
        // Create snapshot
        if let snapImage = viewControllers[index].view.snapshot {
            snapShots[index] = UIImageView(image: snapImage)
        }
    }
}

// MARK: - Move element
extension SVCSwipeViewController {
    private func SVCNavigationBarDelegate(from viewController: UIViewController) -> SVCNavigationBarDelegate? {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first as? SVCNavigationBarDelegate
        }
        return viewController as? SVCNavigationBarDelegate
    }
    
    // Move SVCNavigationBar
    func moveNavigationBar(toItem: Int, fromItem: Int, percent: CGFloat, duration: TimeInterval) {
        navigationBar?.updateBarUsing(delegateFrom: SVCNavigationBarDelegate(from: viewControllers[fromItem]),
                                      delegateTo: SVCNavigationBarDelegate(from: viewControllers[toItem]),
                                      percent: percent,
                                      selectItem: toItem,
                                      duration: duration)
    }
    
    // Move SwitchBar
    func moveTabBar(toItem: Int, fromItem: Int, percent: CGFloat, duration: TimeInterval, isTap: Bool) {
        tabBar?.move(toIndex: toItem,
                        fromIndex: fromItem,
                        percent: percent,
                        isTap: isTap,
                        duration: duration)
    }
    
    // Move ScrollView
    func moveScrollView(toItem: Int, fromItem: Int, duration: TimeInterval) {
        mover.move(true)
        addViewController(index: toItem)
        
        if duration == 0.0 {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.width * CGFloat(toItem), y: 0)
            mover.move(false)
        } else {
            
            addControllers(fromIndex: fromItem, toIndex: toItem)
            
            UIView.animate(withDuration: duration,
                           delay: SVCSwipeViewController.moveVCDelay,
                           options: SVCSwipeViewController.moveVCAnimationOption,
                           animations: { [unowned self] in
                            
                            self.scrollView.contentOffset = CGPoint(x: self.scrollView.bounds.width * CGFloat(toItem), y: 0)
            }, completion: { [weak self] _ in
                
                self?.mover.move(false)
                self?.removeAllControllers()
            })
            
        }
    }
}

// MARK: - SnapShot
extension SVCSwipeViewController {
    func addControllers(fromIndex: Int, toIndex: Int) {
        guard fromIndex != toIndex else {
            return
        }
        
        for i in min(fromIndex, toIndex) + 1 ..< max(fromIndex, toIndex) {
            if let img = snapShots[i] {
                addSnapshot(index: i, snapshot: img)
            } else {
                addViewController(index: i)
            }
        }
    }
    
    func removeControllers(fromIndex: Int, toIndex: Int) {
        guard fromIndex != toIndex else {
            return
        }
        
        for i in min(fromIndex, toIndex) + 1 ..< max(fromIndex, toIndex) {
            if snapShots[i] != nil {
                removeSnapshot(index: i)
            } else {
                removeViewController(index: i)
            }
        }
    }
    
    func removeAllControllers() {
        guard !mover.isMoving else {
            return
        }
        
        for i in 0 ..< viewControllers.count {
            
            removeSnapshot(index: i)
            
            if i == selectedItem {
                continue
            }
            
            removeViewController(index: i)
        }
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
        moveNavigationBar(toItem: toItem,
                          fromItem: selectedItem,
                          percent: percent,
                          duration: 0.01)
        if percent == 1 {
            selectedItem = toItem
        }
    }
    
    /// scrollViewDidEndDecelerating
    ///
    /// - Parameter scrollView: that was scroll
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        removeAllControllers()
    }
}

// MARK: - Handle device orientation
extension SVCSwipeViewController {
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        mover.move(true)
        coordinator.animate(alongsideTransition: { [unowned self] _ -> Void in
            self.updateScrollViewOffset(contentWidth: size.width)
            self.moveNavigationBar(toItem: self.selectedItem,
                                   fromItem: self.previousSelectedItem,
                                   percent: 1,
                                   duration: 0)
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
