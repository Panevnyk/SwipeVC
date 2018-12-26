//
//  SVCTabItem.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Vlad Panevnyk on 18.04.16.
//  Copyright © 2016 Vlad Panevnyk. All rights reserved.
//

import UIKit

/// SVCTabItem
open class SVCTabItem: UIButton, SVCTabItemProtocol {
    
    // ---------------------------------------------------------------------
    // MARK: - Constants
    // ---------------------------------------------------------------------
    
    open var percentChangeForSelection: CGFloat = 0.5
    
    // ---------------------------------------------------------------------
    // MARK: - Public variables
    // ---------------------------------------------------------------------
    
    /// SVCTabBar delegate
    public weak var delegate: SVCTabItemDelegate?
    
    /// Item index
    open var itemIndex = 0
    
    /// Item imageView animators
    open var imageViewAnimators: [SVCAnimator] = []
    
    /// Item titleLabel animators
    open var titleLabelAnimators: [SVCAnimator] = []
    
    // ---------------------------------------------------------------------
    // MARK: - IsSelected
    // ---------------------------------------------------------------------
    
    /// This property can disable standart isSelected state behaviour
    open var shouldUseStandartIsSelectedBehaviour = true
    
    /// Override isSelected, that update IsSelectedState property.
    /// Standart behaviour of this property can be disabled by set "shouldUseStandartIsSelectedBehaviour" to "false"
    open override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            guard newValue != isSelectedState else { return }
            
            isSelectedState = newValue
            
            guard shouldUseStandartIsSelectedBehaviour else { return }
            
            super.isSelected = newValue
        }
        
    }
    
    /// IsSelectedState property update UI using animators on didSet Action
    open var isSelectedState = false {
        didSet {
            update(isSelected: isSelectedState)
        }
    }
    
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
    
    // ---------------------------------------------------------------------
    // MARK: - initialize
    // ---------------------------------------------------------------------
    
    open func initialize() {
        setTitleColor(.black, for: .selected)
        setTitleColor(.gray, for: .normal)
        tintColor = UIColor.clear
        addTarget(self, action: #selector(itemTapAction), for: .touchUpInside)
    }
}

// MARK: - Update
extension SVCTabItem {
    /// updateStyle
    ///
    /// - Parameters:
    ///   - percent: from 0 to 1, where 0 - unselected, 1 - selected
    open func updateStyle(percent: CGFloat) {
        isSelected = percent > percentChangeForSelection
    }
    
    /// update imageView and titleLabel using Animators
    ///
    /// - Parameter isSelected: from isSelectedState property
    open func update(isSelected: Bool) {
        // Update imageView
        if let imageView = imageView {
            if isSelected {
                imageViewAnimators.forEach { $0.select(onView: imageView) }
            } else {
                imageViewAnimators.forEach { $0.deselect(onView: imageView) }
            }
        }
        
        // Update titleLabel
        if let titleLabel = titleLabel {
            if isSelected {
                titleLabelAnimators.forEach { $0.select(onView: titleLabel) }
            } else {
                titleLabelAnimators.forEach { $0.deselect(onView: titleLabel) }
            }
        }
    }
}

// MARK: - Action
private extension SVCTabItem {
    @IBAction func itemTapAction(_ sender: SVCTabItem) {
        delegate?.didSelect(item: itemIndex)
    }
}
