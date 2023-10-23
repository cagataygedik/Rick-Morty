//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 19.10.2023.
//

import UIKit

final class RMTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    private func configureTabBar() {
        UITabBar.appearance().tintColor = .systemGreen
        UINavigationBar.appearance().tintColor = .systemGreen
        
        let charactersViewController = RMCharacterViewController()
        let locationsViewController = RMLocationViewController()
        let episodesViewController = RMEpisodeViewController()
        let settingsViewController = RMSettingsViewController()
        
        let nav1 = UINavigationController(rootViewController: charactersViewController)
        let nav2 = UINavigationController(rootViewController: locationsViewController)
        let nav3 = UINavigationController(rootViewController: episodesViewController)
        let nav4 = UINavigationController(rootViewController: settingsViewController)
        
        
        charactersViewController.navigationItem.largeTitleDisplayMode = .automatic
        locationsViewController.navigationItem.largeTitleDisplayMode = .automatic
        episodesViewController.navigationItem.largeTitleDisplayMode = .automatic
        settingsViewController.navigationItem.largeTitleDisplayMode = .automatic
        
        nav1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
}

