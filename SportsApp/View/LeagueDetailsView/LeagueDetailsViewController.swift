//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Macos on 21/05/2025.
//

import UIKit
import SDWebImage

class LeagueDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, DataHandling {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var sport:Sport?
    var factory:SportFactory?
    private var persenter:Presenter?
    private var isFav=false
    private let customButton = UIButton(type: .system)
    var league:League?
    private var lastestFixture=[Fixture]()
    private var upcoimgFixture=[Fixture]()
    private var teams=[Team]()
    private let colors:[UIColor] = [
        .red,         // Red
        .orange,      // Orange
        .gray,
        .systemMint,
        .blue,        // Blue
        .systemIndigo, // Indigo (iOS 13+)
        .purple       // Violet (using purple instead of violet)
]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = createLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        persenter=Presenter(dataHandle: self)
        if let id=league?.key{
            persenter?.fetchFixtures(sport: sport!, factory: factory!, addOn: "&leagueId=\(id)")
            persenter?.fetchTeam(sport: sport!, factory: factory!, addOn: "&leagueId=\(id)")
        }
        
        checkIfFound()
        collectionView.register(UINib(nibName: "LastestViewCell", bundle: nil), forCellWithReuseIdentifier: "lastestCell")
        collectionView.register(UINib(nibName: "UpcomingViewCell", bundle: nil), forCellWithReuseIdentifier: "upcomingCell")
        collectionView.register(UINib(nibName: "TeamViewCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return lastestFixture.count
        case 1:
            return upcoimgFixture.count
        case 2:
            return teams.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastestCell", for: indexPath) as! LastestViewCell
                let fix = lastestFixture[indexPath.row]
                cell.date.text=fix.date
                cell.time.text=fix.time
                if let imageUrl1 = fix.homeImg {
                    cell.team1Img.sd_setImage(with: URL(string: imageUrl1), placeholderImage: UIImage(named: sport == .tennis ? "tennisPlayer" : "team"))
                } else {
                    cell.team1Img.image = UIImage(named: sport == .tennis ? "tennisPlayer" : "team")
                }
                if let imageUrl2 = fix.awayImg {
                    cell.team2Img.sd_setImage(with: URL(string: imageUrl2), placeholderImage: UIImage(named:sport == .tennis ? "tennisPlayer" : "team"))
                } else {
                    cell.team2Img.image = UIImage(named: sport == .tennis ? "tennisPlayer" : "team")
                }
                if let home = fix.home{
                    cell.team1Text.text=home
                }
                else{
                    cell.team1Text.text="Team 1"
                }
                if let away = fix.away{
                    cell.team2Text.text=away
                }
                else{
                    cell.team2Text.text="Team 2"
                }
                if let result=fix.result{
                    let r=getResluts(result: result)
                    cell.team1Result.text = r[0].lowercased()
                    cell.team2Result.text = r[1].lowercased().replacingOccurrences(of: " ", with: "")
                }
                else{
                    cell.team1Result.text = "-"
                    cell.team2Result.text = "-"
                }
                cell.backgroundColor=colors[indexPath.row % colors.count]
                cell.layer.cornerRadius = 12
                cell.layer.masksToBounds = true
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as! UpcomingViewCell
                let fix = upcoimgFixture[indexPath.row]
                cell.date.text=fix.date
                cell.time.text=fix.time
                if let imageUrl1 = fix.homeImg {
                    cell.team1Img.sd_setImage(with: URL(string: imageUrl1), placeholderImage: UIImage(named: sport == .tennis ? "tennisPlayer" : "team"))
                } else {
                    cell.team1Img.image = UIImage(named: sport == .tennis ? "tennisPlayer" : "team")
                }
                if let imageUrl2 = fix.awayImg {
                    cell.team2Img.sd_setImage(with: URL(string: imageUrl2), placeholderImage: UIImage(named: sport == .tennis ? "tennisPlayer" : "team"))
                } else {
                    cell.team2Img.image = UIImage(named: sport == .tennis ? "tennisPlayer" : "team")
                }
                if let home = fix.home{
                    cell.team1Text.text=home
                }
                else{
                    cell.team1Text.text="Team 1"
                }
                if let away = fix.away{
                    cell.team2Text.text=away
                }
                else{
                    cell.team2Text.text="Team 2"
                }
                cell.backgroundColor = .systemGray5
                cell.layer.cornerRadius = 12
                cell.layer.masksToBounds = true
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamViewCell
                let team = teams[indexPath.row]
                if let imageUrl1 = team.img {
                    cell.img.sd_setImage(with: URL(string: imageUrl1), placeholderImage: UIImage(named: sport == .tennis ? "tennisPlayer" : "team"))
                } else {
                    cell.img.image = UIImage(named: sport == .tennis ? "tennisPlayer" : "team")
                }
                cell.team.text=team.name
                cell.backgroundColor = .systemGray6
                cell.layer.cornerRadius = 12
                cell.layer.masksToBounds = true
                return cell
            default:
                fatalError("Unexpected section")
            }
        }

    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let screenWidth = environment.container.effectiveContentSize.width
            
            switch sectionIndex {

            case 0:
                let itemWidth = screenWidth * 0.5
                let itemHeight = 200.0

                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .absolute(itemHeight)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(44)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [header]

                return section

            case 1:

                let itemHeight = 200.0

                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(itemHeight)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(itemHeight)
                )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(44)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [header]

                return section

            case 2:
                let itemWidth = screenWidth * 0.45
                let itemHeight = 150.0

                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .absolute(itemHeight)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 4, bottom: 10, trailing: 4)
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(44)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [header]

                return section

            default:
                return nil
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderView",
                for: indexPath)
            header.subviews.forEach { $0.removeFromSuperview() }

            let label = UILabel()
            let headerLabel = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            label.textColor = UIColor.gray
            headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
            headerLabel.textColor = .label

            switch indexPath.section {
            case 0:
                if(lastestFixture.isEmpty){
                    headerLabel.text = "Latest Matches"
                    label.text="No Latest Matches Avalaible"
                    label.numberOfLines=3
                }
                else{
                    headerLabel.text = "Latest Matches"
                    label.text=""
                }
            case 1:
                if(upcoimgFixture.isEmpty){
                    headerLabel.text = "Upcoming Matches"
                    label.text="No Upcoming Matches Avalaible"
                    label.numberOfLines=3
                }
                else{
                    headerLabel.text = "Upcoming Matches"
                    label.text=""
                }
            case 2:
                headerLabel.text = sport == .tennis ? "Players" : "Teams"
                if(teams.isEmpty){
                    label.text = "No " + (headerLabel.text ?? "") + " Avalaible"
                }
                label.numberOfLines=3
            default:
                label.text = "Section \(indexPath.section)"
            }

            header.addSubview(label)
            header.addSubview(headerLabel)
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 32),
                label.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16),
                label.topAnchor.constraint(equalTo: header.topAnchor, constant: 64),
                label.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -4),
                headerLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
                headerLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16),
                headerLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 4),
                headerLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -4)
            ])
            
            return header
        }

        return UICollectionReusableView()
    }
    
    func getResluts(result: String) -> [Substring]{
        if result.contains("/"){
            return result.replacingOccurrences(of: "/", with: "").isEmpty ? ["-","-"] : result.split(separator: "/")
        }
        else if result.contains("-"){
            return result.replacingOccurrences(of: "-", with: "").isEmpty ? ["-","-"] : result.split(separator: "-")
        }
        return ["-","-"]
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let teamVc = TeamDetailsViewController()
            teamVc.teamKey = teams[indexPath.row].key
            teamVc.sport = self.sport
            teamVc.factory = self.factory
            navigationController?.pushViewController(teamVc, animated: true)
        }
    }
    
    func addButton(shape:String){
        customButton.setImage(UIImage(systemName: shape), for: .normal)
        customButton.tintColor = .red
        customButton.addTarget(self, action: #selector(favClick), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: customButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func getData(data: [String : Any]) {
        if let fixtures = data["fixtures"] as? [Fixture]{
            for i in fixtures{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                formatter.timeZone = .current
                formatter.locale = .current

                if let givenDate = formatter.date(from: i.date ?? "2020-01-01") {
                    let today = Calendar.current.startOfDay(for: Date())
                    let given = Calendar.current.startOfDay(for: givenDate)
                    if(given>today){
                        upcoimgFixture.append(i)
                    }
                    else{
                        lastestFixture.append(i)
                    }
                }
            }
        }
        
        if let team = data["teams"] as? [Team] {
            teams=team
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showError(error: Error) {
        DispatchQueue.main.async {
            //self.showError(message: error.localizedDescription)
            print("message: \(error.localizedDescription)")
        }
    }
    
    func checkIfFound(){
        let favs=persenter?.leaguesDao.fetchFavoriteLeagues()
        if let favs=favs{
            if(favs.contains(where: {$0.key==league?.key})){
                isFav=true
                addButton(shape: "heart.fill")
            }
            else{
                isFav=false
                addButton(shape: "heart")
            }
        }
        else{
            isFav=false
            addButton(shape: "heart")
        }
    }
    
    func changeType(shape:String){
        customButton.setImage(UIImage(systemName: shape), for: .normal)
    }
    
    @objc func favClick(){
        if(isFav){
            persenter?.leaguesDao.deleteLeagueFromFavorites(key: league?.key ?? 0)
            changeType(shape: "heart")
        }
        else{
            persenter?.leaguesDao.saveLeagueToFavorites(league: league!, sport: sport!.data)
            changeType(shape: "heart.fill")
        }
        isFav = !isFav
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "There is something wrong", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
        present(alert, animated: true)
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
