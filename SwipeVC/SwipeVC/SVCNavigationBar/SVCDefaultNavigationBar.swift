//
//  SVCDefaultNavigationBar.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 9/5/17.
//  Copyright © 2017 Vlad Panevnyk. All rights reserved.
//

import UIKit

/// SVCDefaultNavigationBar
open class SVCDefaultNavigationBar: UIView, SVCNavigationBar {
    // Public variable
    /// Font
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 17) {
        didSet {
            titleViewFrom.font = titleFont
            titleViewTo.font = titleFont
        }
    }
    /// TitleColor
    public var titleTextColor: UIColor = UIColor.black {
        didSet {
            titleViewFrom.textColor = titleTextColor
            titleViewTo.textColor = titleTextColor
        }
    }
    /// Number of lines
    public var titleNumberOfLines: Int = 1 {
        didSet {
            titleViewFrom.numberOfLines = titleNumberOfLines
            titleViewTo.numberOfLines = titleNumberOfLines
        }
    }
    
    // Static variable
    /// BG view for items top space
    public static let defaultNavigationBGViewForItemsTopSpace: CGFloat = 0
    /// Default navigation bar height
    public static let defaultNavigationBarHeight: CGFloat = 644
    /// BG view for items height
    public static let defaultNavigationBGViewForItemsHeight: CGFloat = 44
    private static let itemSpaceInGroupView: CGFloat = 7.5
    
    /// Middle navigation
    private lazy var middleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleViewFrom: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }()
    private lazy var titleViewTo: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }()
    private var leftGroupView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private lazy var rightGroupView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private var fromLeftGroupItems: [SVCNavigationItem] = []
    private var fromRightGroupItems: [SVCNavigationItem] = []
    private var toLeftGroupItems: [SVCNavigationItem] = []
    private var toRightGroupItems: [SVCNavigationItem] = []
    private var cnstrLeftGroupViewWidth: NSLayoutConstraint?
    private var cnstrRightGroupViewWidth: NSLayoutConstraint?
    
    /// Bottom navigation
    private lazy var bottomContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    private var bottomViewFrom: UIView?
    private var bottomViewTo: UIView?
    private var bottomViewFromHeight: CGFloat = 0
    private var bottomViewToHeight: CGFloat = 0
    private var cnstrBottomContainerViewHeight: NSLayoutConstraint?
    
    /// Adding variable
    private var selectItem = -1

    /// Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializer()
    }
    
    func initializer() {
        layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: 1)
        
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = false
        initializeConstraints()
    }
}

// MARK: - UI
extension SVCDefaultNavigationBar {
    func initializeConstraints() {
        initializeMiddleView()
        initializeBottomContainerView()
    }
    
    func initializeMiddleView() {
        /// middleView
        addSubview(middleView)
        
        let middleLeft: NSLayoutConstraint
        let middleRight: NSLayoutConstraint
        if #available(iOS 11.0, *) {
            middleLeft = middleView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
            middleRight = safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: middleView.trailingAnchor)
        } else {
            middleLeft = middleView.leadingAnchor.constraint(equalTo: leadingAnchor)
            middleRight = trailingAnchor.constraint(equalTo: middleView.trailingAnchor)
        }

        let middleTop = middleView.topAnchor.constraint(equalTo: topAnchor,
                                                        constant: UIApplication.shared.statusBarFrame.height)
        let middleHeight = middleView.heightAnchor.constraint(equalToConstant: SVCDefaultNavigationBar.defaultNavigationBGViewForItemsHeight)
        
        /// titleViewFrom
        middleView.addSubview(titleViewFrom)
        let titleViewFromTop = titleViewFrom.topAnchor.constraint(equalTo: middleView.topAnchor)
        let titleViewFromBottom = middleView.bottomAnchor.constraint(equalTo: titleViewFrom.bottomAnchor)
        let titleViewFromCenterX = middleView.centerXAnchor.constraint(equalTo: titleViewFrom.centerXAnchor)
        
        /// titleViewTo
        middleView.addSubview(titleViewTo)
        let titleViewToTop = titleViewTo.topAnchor.constraint(equalTo: middleView.topAnchor)
        let titleViewToBottom = middleView.bottomAnchor.constraint(equalTo: titleViewTo.bottomAnchor)
        let titleViewToCenterX = middleView.centerXAnchor.constraint(equalTo: titleViewTo.centerXAnchor)
        
        /// leftGroupView
        middleView.addSubview(leftGroupView)
        let leftGroupViewLeft = leftGroupView.leadingAnchor.constraint(equalTo: middleView.leadingAnchor)
        let leftGroupViewTop = leftGroupView.topAnchor.constraint(equalTo: middleView.topAnchor)
        cnstrLeftGroupViewWidth = leftGroupView.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 0.5)
        let leftGroupViewBottom = middleView.bottomAnchor.constraint(equalTo: leftGroupView.bottomAnchor)
        
        /// rightGroupView
        middleView.addSubview(rightGroupView)
        let rightGroupViewRight = middleView.trailingAnchor.constraint(equalTo: rightGroupView.trailingAnchor)
        let rightGroupViewTop = rightGroupView.topAnchor.constraint(equalTo: middleView.topAnchor)
        cnstrRightGroupViewWidth = rightGroupView.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 0.5)
        let rightGroupViewBottom = middleView.bottomAnchor.constraint(equalTo: rightGroupView.bottomAnchor)
        
        guard let cnstrLeftGroupViewWidth = cnstrLeftGroupViewWidth,
            let cnstrRightGroupViewWidth = cnstrRightGroupViewWidth else {
            return
        }
        /// Activate
        NSLayoutConstraint.activate([middleLeft, middleTop, middleRight, middleHeight,
                                     titleViewFromTop, titleViewFromBottom, titleViewFromCenterX,
                                     titleViewToTop, titleViewToBottom, titleViewToCenterX,
                                     leftGroupViewLeft, leftGroupViewTop, cnstrLeftGroupViewWidth, leftGroupViewBottom,
                                     rightGroupViewTop, cnstrRightGroupViewWidth, rightGroupViewRight, rightGroupViewBottom])
    }
    
    func initializeBottomContainerView() {
        addSubview(bottomContainerView)
        let left = bottomContainerView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let top = bottomContainerView.topAnchor.constraint(equalTo: middleView.bottomAnchor)
        let right = trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor)
        let bottom = bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor)
        cnstrBottomContainerViewHeight = bottomContainerView.heightAnchor.constraint(equalToConstant: 0)
        
        guard let cnstrBottomContainerViewHeight = cnstrBottomContainerViewHeight else {
           return
        }
        NSLayoutConstraint.activate([left, top, right, bottom, cnstrBottomContainerViewHeight])
    }
    
    func addBottomSubView(addedView: UIView) -> UIView {
        let addedView = addedView
        addedView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.addSubview(addedView)
        NSLayoutConstraint.activate(addedView.constraint(toView: bottomContainerView))
        
        return addedView
    }
    
    /// if fixToLeftSide = true -> add left constrain
    /// if fixToLeftSide = false -> add right constrain
    func addSubviews(items: [SVCNavigationItem], superView: UIView, fixToLeftSide: Bool) {
        for i in 0 ..< items.count {
            let item = items[i]
            item.translatesAutoresizingMaskIntoConstraints = false
            superView.addSubview(item)
            
            var fromAttribute: NSLayoutConstraint.Attribute!
            var toAttribute: NSLayoutConstraint.Attribute!
            var fromItem: UIView!
            var toItem: UIView!
            
            if fixToLeftSide {
                fromItem = item
                fromAttribute = .leading
                if i == 0 {
                    toItem = superView
                    toAttribute = .leading
                } else {
                    toItem = items[i - 1]
                    toAttribute = .trailing
                }
            } else {
                toItem = item
                toAttribute = .trailing
                if i == 0 {
                    fromItem = superView
                    fromAttribute = .trailing
                } else {
                    fromItem = items[i - 1]
                    fromAttribute = .leading
                }
            }
            
            NSLayoutConstraint.activate([NSLayoutConstraint(item: fromItem,
                                                            attribute: fromAttribute,
                                                            relatedBy: .equal,
                                                            toItem: toItem,
                                                            attribute: toAttribute,
                                                            multiplier: 1,
                                                            constant: SVCDefaultNavigationBar.itemSpaceInGroupView),
                                         item.widthAnchor.constraint(equalToConstant: item.frame.size.width),
                                         item.heightAnchor.constraint(equalToConstant: item.frame.size.height),
                                         item.centerYAnchor.constraint(equalTo: superView.centerYAnchor)])
        }
    }
}

// MARK: - Update SVCNavigationBar
extension SVCDefaultNavigationBar {
    /// updateBarUsing
    ///
    /// - Parameters:
    ///   - delegateFrom: delegate from change
    ///   - delegateTo: delegate to change
    ///   - percent: percent of change
    ///   - selectItem: current select item
    ///   - duration: duration for animation change
    public func updateBarUsing(delegateFrom: SVCNavigationBarDelegate?,
                               delegateTo: SVCNavigationBarDelegate?,
                               percent: CGFloat,
                               selectItem: Int,
                               duration: TimeInterval) {
        var needReCreate = false
        if selectItem != self.selectItem {
            self.selectItem = selectItem
            needReCreate = true
        }
        
        let updateTitle = updateTitleViewFromUsing(delegateFrom: delegateFrom,
                                                   delegateTo: delegateTo,
                                                   percent: percent,
                                                   needReCreate: needReCreate)
        let updateGroupsItems = updateGroupsItemsFromUsing(delegateFrom: delegateFrom,
                                                           delegateTo: delegateTo,
                                                           percent: percent,
                                                           needReCreate: needReCreate)
        let updateBarBottomView = updateBarBottomViewUsing(delegateFrom: delegateFrom,
                                                           delegateTo: delegateTo,
                                                           percent: percent,
                                                           needReCreate: needReCreate)
        
        middleView.layoutIfNeeded()
        
        /// To: slow at beginning
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear/*.curveEaseIn*/, animations: {
            updateTitle.to()
            updateGroupsItems.to()
            updateBarBottomView.to()
        }, completion: nil)
        /// From: slow at end
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear/*.curveEaseOut*/, animations: {
            updateTitle.from()
            updateGroupsItems.from()
            updateBarBottomView.from()
        }, completion: nil)
        /// linear
        UIView.animate(withDuration: duration, animations: {
            self.superview?.layoutIfNeeded()
        }, completion: { _ in })
    }
    
    func updateTitleViewFromUsing(delegateFrom: SVCNavigationBarDelegate?,
                                  delegateTo: SVCNavigationBarDelegate?,
                                  percent: CGFloat,
                                  needReCreate: Bool) -> (from: () -> Void, to: () -> Void) {
        if needReCreate {
            /// From
            let fromString = delegateFrom?.navigationBarTitle() ?? ""
            titleViewFrom.text = fromString
            titleViewFrom.alpha = 1
            
            /// To
            let toString = delegateTo?.navigationBarTitle() ?? ""
            titleViewTo.text = toString
            titleViewTo.alpha = 0
        }
        
        /// update left and right viewGroup
        let sizeTo = titleViewTo.sizeThatFits(CGSize(width: middleView.frame.size.width, height: middleView.frame.size.height))
        let sizeFrom = titleViewFrom.sizeThatFits(CGSize(width: middleView.frame.size.width, height: middleView.frame.size.height))
        
        let newItemGroupViewWidth = (-sizeFrom.width + ((sizeFrom.width - sizeTo.width) * percent)) / 2
        cnstrLeftGroupViewWidth?.constant = newItemGroupViewWidth
        cnstrRightGroupViewWidth?.constant = newItemGroupViewWidth
        
        func animateMethodFrom() {
            titleViewFrom.alpha = SVCInterpolateHelper.getPointBy(xPoint: 1 - percent, curve: .easeOut)
        }
        func animateMethodTo() {
            titleViewTo.alpha = SVCInterpolateHelper.getPointBy(xPoint: percent, curve: .easeIn)
        }
        return (animateMethodFrom, animateMethodTo)
    }
    
    func updateGroupsItemsFromUsing(delegateFrom: SVCNavigationBarDelegate?,
                                    delegateTo: SVCNavigationBarDelegate?,
                                    percent: CGFloat,
                                    needReCreate: Bool) -> (from: () -> Void, to: () -> Void) {
        if needReCreate {
            _ = fromLeftGroupItems.map({ (item) -> Void in item.removeFromSuperview() })
            _ = fromRightGroupItems.map({ (item) -> Void in item.removeFromSuperview() })
            _ = toLeftGroupItems.map({ (item) -> Void in item.removeFromSuperview() })
            _ = toRightGroupItems.map({ (item) -> Void in item.removeFromSuperview() })
            
            /// Left From
            fromLeftGroupItems = delegateFrom?.navigationBarLeftGroupItems() ?? []
            addSubviews(items: fromLeftGroupItems, superView: leftGroupView, fixToLeftSide: true)
            
            /// Right From
            fromRightGroupItems = delegateFrom?.navigationBarRightGroupItems() ?? []
            addSubviews(items: fromRightGroupItems, superView: rightGroupView, fixToLeftSide: false)
            
            /// Left To
            toLeftGroupItems = delegateTo?.navigationBarLeftGroupItems() ?? []
            addSubviews(items: toLeftGroupItems, superView: leftGroupView, fixToLeftSide: true)
            
            /// Right To
            toRightGroupItems = delegateTo?.navigationBarRightGroupItems() ?? []
            addSubviews(items: toRightGroupItems, superView: rightGroupView, fixToLeftSide: false)
            
            _ = toLeftGroupItems.map({ (item) -> Void in
                item.transform = CGAffineTransform(scaleX: 0, y: 0)
                item.alpha = 0
            })
            _ = toRightGroupItems.map({ (item) -> Void in
                item.transform = CGAffineTransform(scaleX: 0, y: 0)
                item.alpha = 0
            })
            
        }
        
        let fromPercentForAlpha = SVCInterpolateHelper.getPointBy(xPoint: 1 - percent == 0 ? 0.001 : 1 - percent, curve: .linear)
        let toPercentForAlpha = SVCInterpolateHelper.getPointBy(xPoint: percent == 0 ? 0.001 : percent, curve: .linear)
        let fromPercent = SVCInterpolateHelper.getPointBy(xPoint: 1 - percent == 0 ? 0.001 : 1 - percent, curve: .linear)
        let toPercent = SVCInterpolateHelper.getPointBy(xPoint: percent == 0 ? 0.001 : percent, curve: .linear)
        
        func animateMethodFrom() {
            _ = fromLeftGroupItems.map({ (item) -> Void in
                item.transform = CGAffineTransform(scaleX: fromPercent, y: fromPercent)
                item.alpha = fromPercentForAlpha
            })
            _ = fromRightGroupItems.map({ (item) -> Void in
                item.transform = CGAffineTransform(scaleX: fromPercent, y: fromPercent)
                item.alpha = fromPercentForAlpha
            })
        }
        func animateMethodTo() {
            _ = toLeftGroupItems.map({ (item) -> Void in
                item.transform = CGAffineTransform(scaleX: toPercent, y: toPercent)
                item.alpha = toPercentForAlpha
            })
            _ = toRightGroupItems.map({ (item) -> Void in
                item.transform = CGAffineTransform(scaleX: toPercent, y: toPercent)
                item.alpha = toPercentForAlpha
            })
        }
        return (animateMethodFrom, animateMethodTo)
    }
    
    func updateBarBottomViewUsing(delegateFrom: SVCNavigationBarDelegate?,
                                  delegateTo: SVCNavigationBarDelegate?,
                                  percent: CGFloat,
                                  needReCreate: Bool) -> (from: () -> Void, to: () -> Void) {
        if needReCreate {
            /// From
            bottomViewFrom?.removeFromSuperview()
            let fromView = delegateFrom?.navigationBarBottomView() ?? UIView(frame: CGRect.zero)
            bottomViewFromHeight = fromView.frame.size.height
            bottomViewFrom = addBottomSubView(addedView: fromView)
            
            /// To
            bottomViewTo?.removeFromSuperview()
            let toView = delegateTo?.navigationBarBottomView() ?? UIView(frame: CGRect.zero)
            bottomViewToHeight = toView.frame.size.height
            bottomViewTo = addBottomSubView(addedView: toView)
            bottomViewTo?.alpha = 0
            
            /// layoutIfNeeded All Bottom View
            bottomContainerView.layoutIfNeeded()
        }
        
        let newBottomViewHeight = bottomViewFromHeight + ((bottomViewToHeight - bottomViewFromHeight) * percent)
        cnstrBottomContainerViewHeight?.constant = newBottomViewHeight
        
        func animateMethodFrom() {
            bottomViewFrom?.alpha = SVCInterpolateHelper.getPointBy(xPoint: 1 - percent, curve: .easeOut)
        }
        func animateMethodTo() {
            bottomViewTo?.alpha = SVCInterpolateHelper.getPointBy(xPoint: percent, curve: .easeIn)
        }
        return (animateMethodFrom, animateMethodTo)
    }
}
