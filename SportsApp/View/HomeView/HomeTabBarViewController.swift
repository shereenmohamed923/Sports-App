//
//  HomeTabBarViewController.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        tabBar.tintColor = UIColor.red
        }

        private func setupTabBar() {
            let sportsVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
            let favoritesVC = FavoritesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
            
            
            sportsVC.tabBarItem = UITabBarItem(title: "Sports", image: UIImage(systemName: "house.fill"), tag: 0)
            favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)

            self.viewControllers = [sportsVC, favoritesVC]
        }

}
