//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit
import SDWebImage

class LeaguesTableViewController: UITableViewController, DataHandling {
    func getData(data: [String : Any]) {
        if let leag = data["leagues"] as? [League] {
            leagues=leag
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func showError(error: Error) {
        DispatchQueue.main.async {
            self.showError(message: error.localizedDescription)
        }
    }
    
    
    private var leagues: [League] = []
    var sport:Sport?
    var factory:SportFactory?
    private var presenter:Presenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "leaguesCell")
        
        presenter = Presenter(dataHandle: self)
        presenter?.fetchLeagues(sport: sport!, factory: factory!)
    }
    
    
    func showError(message: String) {
        let alert = UIAlertController(title: "There is something wrong", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaguesTableViewCell
        let league = leagues[indexPath.row]
        
        cell.leageName.text = league.name
        if let imageUrl = league.img {
            cell.leagueImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "sports"))
        } else {
            cell.leagueImage.image = UIImage(named: "sports")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC=LeagueDetailsViewController(nibName: "LeagueDetailsViewController", bundle: nil)
        detailsVC.factory=factory
        detailsVC.sport=sport
        detailsVC.league = leagues[indexPath.row]
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.pushViewController(detailsVC, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
