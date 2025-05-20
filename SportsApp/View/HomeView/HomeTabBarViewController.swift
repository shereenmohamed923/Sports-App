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
        }

        private func setupTabBar() {
            let sportsVC = SportsViewController(nibName: "SportsViewController", bundle: nil)
            let favoritesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)

            sportsVC.tabBarItem = UITabBarItem(title: "Sports", image: UIImage(systemName: "house.fill"), tag: 0)
            favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)

            self.viewControllers = [sportsVC, favoritesVC]
        }

}
