//
//  MainPageViewController.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 13.10.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTabBarFrame()
    }
    
    func updateTabBarFrame() {
        let tabBarHeight: CGFloat = 55
        let tabBarYPosition = view.frame.height - tabBarHeight - 40
        tabBar.frame = CGRect(x: 25, y: tabBarYPosition, width: view.frame.width - 50, height: tabBarHeight)
        
    }
    
    
    func configureUI() {
        view.backgroundColor = .white
        let first = MainPageeViewController()
        let second = SettingsViewController()
        
        let nav1 = UINavigationController(rootViewController: first)
        let nav2 = UINavigationController(rootViewController: second)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "newspaper"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        let font =  [NSAttributedString.Key.font:UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)]
        
        for nav in [nav1,nav2] {
            nav.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0 , vertical: -1)
            nav.tabBarItem.setTitleTextAttributes(font as [NSAttributedString.Key : Any], for: .normal)
        }
        setViewControllers([nav1,nav2], animated: true)
        self.tabBar.tintColor = .systemMint
        self.tabBar.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        tabBar.barTintColor =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        self.tabBar.itemPositioning = .fill
        self.tabBar.unselectedItemTintColor = .systemGray
        tabBar.layer.cornerRadius = 16
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 5, height: 10)
        tabBar.layer.shadowOpacity = 1.2
        tabBar.clipsToBounds = true
        
        
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    
}

