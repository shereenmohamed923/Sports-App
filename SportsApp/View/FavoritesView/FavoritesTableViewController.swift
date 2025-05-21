//
//  FavoritesViewController.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    var leagues: [League] = []
    var favoritePresenter: FavoritePresenter?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "leaguesCell")
        
        favoritePresenter = FavoritePresenter(favoritesVC: self)
        favoritePresenter?.fetchFavoriteLeagues()
    }
    
    func reload(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
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
       if let imageUrl = league.img, let url = URL(string: imageUrl) {
           cell.leagueImage.sd_setImage(with: url, placeholderImage: UIImage(named: "league placeholder"))
       } else {
           cell.leagueImage.image = UIImage(named: "league placeholder")
       }
       
       return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                                forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let leagueToDelete = leagues[indexPath.row]
                if let key = leagueToDelete.key {
                    favoritePresenter?.deleteLeagueFromFavorites(key: key)
                }
                leagues.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }

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
