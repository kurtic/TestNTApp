//
//  BaseTabBarVC.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 10.05.2023.
//

import UIKit

final class BaseTabBarVC: UITabBarController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configTabBar()
    }
    
    // MARK: - GUI
    private func configTabBar() {
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
    }
    
    private func setup() {
        tabBar.unselectedItemTintColor = .black
    }
}
