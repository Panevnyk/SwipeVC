//
//  SVCDefaultCollectionTabBar.swift
//  SVCSwipeViewControllerSwift
//
//  Created by Panevnyk Vlad on 8/21/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class SVCDefaultCollectionTabBar: UIView, SVCTabBar {
    private static let identifier = "DefaultCollectionTabBarCell"

    /// Switch bar items
    public var items: [UIView] = []
    /// SVCTabBarDelegate
    public weak var delegate: SVCTabBarDelegate?
    /// Height of switch bar
    public var height: CGFloat = 44
    /// selectedIndex
    public var selectedIndex: Int?
    
    /// UICollectionView that contain items for manage screens
    public var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(DefaultCollectionTabBarCell.self, forCellWithReuseIdentifier: SVCDefaultCollectionTabBar.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        
        NSLayoutConstraint.activate(collectionView.constraint(toView: self))
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
            collectionView.scrollToItem(at: IndexPath(row: toIndex, section: 0), at: .centeredHorizontally, animated: true)
            if let cell = collectionView.cellForItem(at: IndexPath(item: fromIndex, section: 0)) {
                cell.backgroundColor = UIColor.clear
            }
            if let cell = collectionView.cellForItem(at: IndexPath(item: toIndex, section: 0)) {
                cell.backgroundColor = UIColor.purple
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SVCDefaultCollectionTabBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable:next force_cast line_length
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SVCDefaultCollectionTabBar.identifier, for: indexPath) as! DefaultCollectionTabBarCell
        cell.backgroundColor = (selectedIndex ?? -1) == indexPath.row ? UIColor.purple : UIColor.clear
        
        cell.titleLabel.textColor = UIColor.white
        cell.titleLabel.text = "cell " + String(indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.select(item: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: collectionView.bounds.size.height)
    }
}

// MARK: - DefaultCollectionTabBarCell
open class DefaultCollectionTabBarCell: UICollectionViewCell {
    /// title of item
    open let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
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
        NSLayoutConstraint.activate(titleLabel.constraint(toView: self))
    }
}
