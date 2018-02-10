//
//  SVCDefaultCollectionTabBar.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 8/21/17.
//  Copyright © 2017 Vlad Panevnyk. All rights reserved.
//

import UIKit

class SVCDefaultCollectionTabBar: UIView, SVCTabBar {
    /// Constants
    private static let identifier = "DefaultCollectionTabBarCell"

    /// Switch bar text
    public var texts: [String] = []
    public var textColor: UIColor = UIColor.black
    public var textFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    /// SVCTabBarDelegate
    public weak var delegate: SVCTabBarDelegate?
    
    /// Height of switch bar
    public var height: CGFloat = 44
    public var heightOfCells: CGFloat = 44
    
    /// SelectedIndex
    public var selectedIndex: Int?
    
    /// UICollectionView that contain items for manage screens
    public let collectionViewLayout = UICollectionViewFlowLayout()
    public var collectionView: UICollectionView?
    
    /// Inits
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initializer()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializer()
    }
    
    private func initializer() {
        translatesAutoresizingMaskIntoConstraints = false
        
        /// collectionView
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView?.register(DefaultCollectionTabBarCell.self, forCellWithReuseIdentifier: SVCDefaultCollectionTabBar.identifier)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        if let collectionView = collectionView {
            addSubview(collectionView)
            NSLayoutConstraint.activate(collectionView.constraint(toView: self))
        }
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
        if percent == 1 {
            selectedIndex = toIndex
        }
        
        if percent == 1 {
            collectionView?.scrollToItem(at: IndexPath(row: toIndex, section: 0), at: .centeredHorizontally, animated: true)
            if let cell = collectionView?.cellForItem(at: IndexPath(item: fromIndex, section: 0)) {
                cell.backgroundColor = UIColor.clear
            }
            if let cell = collectionView?.cellForItem(at: IndexPath(item: toIndex, section: 0)) {
                cell.backgroundColor = UIColor.purple
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SVCDefaultCollectionTabBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return texts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SVCDefaultCollectionTabBar.identifier, for: indexPath) as! DefaultCollectionTabBarCell
        
        cell.titleLabel.font = textFont
        cell.titleLabel.textColor = textColor
        cell.titleLabel.text = texts[indexPath.row]
        cell.height = heightOfCells
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.select(item: indexPath.row)
    }
}

// MARK: - DefaultCollectionTabBarCell
open class DefaultCollectionTabBarCell: UICollectionViewCell {
    /// height
    public var height: CGFloat = 44 {
        didSet {
            if cnstrTitleLabelHeight != nil,
                cnstrTitleLabelHeight?.constant != height {
                cnstrTitleLabelHeight?.constant = height
            }
        }
    }
    
    /// title of item
    open let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    /// cnstr
    var cnstrTitleLabelHeight: NSLayoutConstraint?
    
    /// Inits
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initializer()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializer()
    }
    
    private func initializer() {
        addSubview(titleLabel)
        cnstrTitleLabelHeight = titleLabel.heightAnchor.constraint(equalToConstant: height)
        var cnstrs = titleLabel.constraint(toView: self)
        if let cnstrTitleLabelHeight = cnstrTitleLabelHeight {
            cnstrs.append(cnstrTitleLabelHeight)
        }
        NSLayoutConstraint.activate(cnstrs)
    }
}
