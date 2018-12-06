//
//  ViewController.swift
//  Example
//
//  Created by Panevnyk Vlad on 12/5/18.
//  Copyright © 2018 Panevnyk Vlad. All rights reserved.
//

import UIKit
import SwipeVC

final class ExampleSwipeViewController: SVCSwipeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeVC()
    }
}

// MARK: - Setup SVCSwipeViewController
private extension ExampleSwipeViewController {
    func setupSwipeVC() {
        addViewControllers()
        tabBarInjection()
    }
    
    func addViewControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        
        viewControllers = [firstViewController, secondViewController, thirdViewController]
    }
    
    func tabBarInjection() {
        let defaultTabBar = SVCDefaultTabBar()
        defaultTabBar.backgroundColor = UIColor.orange
        
        // Init first item
        let firstItem = SVCTabItem(type: .system)
        firstItem.setTitle("First Item", for: .normal)
        firstItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        // Init second item
        let secondItem = SVCTabItem(type: .system)
        secondItem.setTitle("Second Item", for: .normal)
        secondItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        // Init third item
        let thirdItem = SVCTabItem(type: .system)
        thirdItem.setTitle("Third Item", for: .normal)
        secondItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        defaultTabBar.items = [firstItem, secondItem, thirdItem]
        
        // inject tab bar
        tabBar = defaultTabBar
    }
}
