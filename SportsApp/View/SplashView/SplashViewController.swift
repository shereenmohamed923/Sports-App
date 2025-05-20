//
//  SplashViewController.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.navigateToHomeTabBar()
            }
        }

        private func navigateToHomeTabBar() {
            let tabBarController = HomeTabBarViewController()

            if let navigationController = self.navigationController {
                navigationController.setViewControllers([tabBarController], animated: true)
            }
        }

}
