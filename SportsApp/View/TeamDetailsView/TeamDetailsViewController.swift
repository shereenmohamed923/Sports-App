//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Macos on 22/05/2025.
//

import UIKit

class TeamDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DataHandling {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    private var persenter:Presenter?
    private var teams: [Team] = []
    var team: Team?
    var teamKey: Int?
    var sport:Sport?
    var factory:SportFactory?
    
    override func viewWillAppear(_ animated: Bool) {
        persenter=Presenter(dataHandle: self)
        if let teamKey=teamKey{
            persenter?.fetchTeam(sport: sport!, factory: factory!, addOn: "&teamId=\(teamKey)")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView(){
        
               let nib = UINib(nibName: "PlayersCollectionViewCell", bundle: nil)
               collectionView.register(nib, forCellWithReuseIdentifier: "playerCell")

               collectionView.dataSource = self
               collectionView.delegate = self

               if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.minimumInteritemSpacing = 8
                   layout.minimumLineSpacing = 16
                   layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
               }
    }
    
    func setupHeaderUI(){
        print("team name: \(team?.name)")
        teamName.text = team?.name
        if let imageUrl = team?.img{
            teamLogo.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "team"))
        }else{
            teamLogo.image = UIImage(named: "team")
        }
    }
    
    func getData(data: [String : Any]) {
        if let teamData = data["teams"] as? [Team] {
            teams=teamData
            team = teams[0]
            DispatchQueue.main.async {
                        self.setupHeaderUI()
                        self.collectionView.reloadData()
                    }
        }
    }
    
    func showError(error: Error) {
        print(error.localizedDescription)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return team?.players?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"playerCell", for: indexPath) as? PlayersCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        switch indexPath.section {
        case 0:
            let coach = team?.coach
            cell.playerName.text = coach
            cell.playerPos.text = "Coach"
            cell.playerImage.image = UIImage(named: "coach")
        case 1:
            let player = team?.players?[indexPath.item]
            cell.playerName.text = player?.name
            cell.playerPos.text = player?.pos ?? "Player"
            cell.playerNumber.text = player?.number ?? "0"
            if let imageUrl = player?.image{
                cell.playerImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "player"))
            }else{
                cell.playerImage.image = UIImage(named: "player")
            }
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let padding: CGFloat = 32
           let availableWidth = collectionView.frame.width - padding

           if indexPath.section == 0 {
               return CGSize(width: availableWidth, height: 200)
           } else {
               let width = (availableWidth - 8) / 2
               return CGSize(width: width, height:200)
           }
       }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Coaches"
        case 1:
            return "Players"
        default:
            return nil
        }
    }
}
