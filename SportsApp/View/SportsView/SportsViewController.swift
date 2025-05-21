//
//  HomeViewController.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class SportsViewController: UIViewController {

    @IBAction func gotoLeagues(_ sender: Any) {
        let leaguesVC = LeaguesTableViewController()

        if let navigationController = self.navigationController {
            navigationController.setViewControllers([leaguesVC], animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
