//
//  FavoritesViewController.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    var leagues: [FavoriteLeague] = []
    var favoritePresenter: FavoritePresenter?
    var sport: Sport?

    let items = [HomeSport(title: "Football", playerImg: "PlayerFoot", backgroundImg: "BackFoot", sport: .football, factory: FootballFactory()), HomeSport(title: "Cricket", playerImg: "PlayerCrick", backgroundImg: "BackCrick", sport: .cricket, factory: CricketFactory()),HomeSport(title: "Basketball", playerImg: "PlayerBasket", backgroundImg: "BackBasket", sport: .basketball, factory: BasketballFactory()), HomeSport(title: "Tennis", playerImg: "PlayerTennis", backgroundImg: "BackTennis", sport: .tennis, factory: TennisFactory()),]
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "leaguesCell")
        favoritePresenter = FavoritePresenter(favoritesVC: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritePresenter?.fetchFavoriteLeagues()
        reload()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if NetworkMonitor.shared.isConnected==false{
            showNoNetwork()
        }else{
            let detailsVC=LeagueDetailsViewController(nibName: "LeagueDetailsViewController", bundle: nil)
            var index: Int?
            switch leagues[indexPath.row].sport {
            case "football":
                index = 0
            case "cricket":
                index = 1
            case "basketball":
                index = 2
            case "tennis":
                index = 3
            default:
                return
            }
            let current=items[index!]
            detailsVC.factory=current.factory
            detailsVC.sport=current.sport
            var favoriteLeague = leagues[indexPath.row]
            var league = League(key: favoriteLeague.key, name: favoriteLeague.name, img: favoriteLeague.img)
            detailsVC.league = league
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }

    func showNoNetwork() {
        let alert = UIAlertController(title: "Error", message: "There is no internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
        present(alert, animated: true)
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
