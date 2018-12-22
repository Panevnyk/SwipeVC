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
    private static let defaultStyleColor = UIColor(red: 30.0 / 255.0, green: 83.0 / 255.0, blue: 106.0 / 255.0, alpha: 1.0)
    
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
        tabBarType = .bottom
        
        let defaultTabBar = SVCTabBar()
        showMovableView(onDefaultTabBar: defaultTabBar)
        
        // Init first item
        let firstItem = SVCTabItem(type: .system)
        firstItem.setImage(UIImage(named: "ic_location_menu_normal")?.withRenderingMode(.alwaysOriginal), for: .normal)
        firstItem.setImage(UIImage(named: "ic_location_menu_selected")?.withRenderingMode(.alwaysOriginal), for: .selected)
        
        // Init second item
        let secondItem = SVCTabItem(type: .system)
        secondItem.setImage(UIImage(named: "ic_users_menu_normal")?.withRenderingMode(.alwaysOriginal), for: .normal)
        secondItem.setImage(UIImage(named: "ic_users_menu_selected")?.withRenderingMode(.alwaysOriginal), for: .selected)
        
        // Init third item
        let thirdItem = SVCTabItem(type: .system)
        thirdItem.setImage(UIImage(named: "ic_media_menu_normal")?.withRenderingMode(.alwaysOriginal), for: .normal)
        thirdItem.setImage(UIImage(named: "ic_media_menu_selected")?.withRenderingMode(.alwaysOriginal), for: .selected)
        
        defaultTabBar.items = [firstItem, secondItem, thirdItem]
        
        // inject tab bar
        tabBar = defaultTabBar
    }
    
    func showMovableView(onDefaultTabBar defaultTabBar: SVCTabBar) {
        defaultTabBar.movableView.isHidden = false
        defaultTabBar.movableView.backgroundColor = ExampleSwipeViewController.defaultStyleColor
        defaultTabBar.movableView.bouncing = 0.5
        defaultTabBar.movableView.attach = .top
    }
}
