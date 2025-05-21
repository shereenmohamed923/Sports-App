//
//  HomeViewController.swift
//  SportsApp
//
//  Created by Macos on 20/05/2025.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let items = [HomeSport(title: "Football", playerImg: "PlayerFoot", backgroundImg: "BackFoot", sport: .football, factory: FootballFactory()), HomeSport(title: "Cricket", playerImg: "PlayerCrick", backgroundImg: "BackCrick", sport: .cricket, factory: CricketFactory()),HomeSport(title: "Basketball", playerImg: "PlayerBasket", backgroundImg: "BackBasket", sport: .basketball, factory: BasketballFactory()), HomeSport(title: "Tennis", playerImg: "PlayerTennis", backgroundImg: "BackTennis", sport: .tennis, factory: TennisFactory()),]
    
    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource=self
        collection.delegate=self
        
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return items.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCell else {
                return UICollectionViewCell()
            }
        cell.sportName.text = items[indexPath.item].title
        cell.background.image = UIImage(named: items[indexPath.item].backgroundImg)
        cell.player.image = UIImage(named: items[indexPath.item].playerImg)
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {

            let itemsPerRow: CGFloat = 2
            let spacing: CGFloat = 10
            let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

            let totalSpacing = insets.left + insets.right + spacing * (itemsPerRow - 1)
            let availableWidth = collectionView.bounds.width - totalSpacing
            let itemWidth = floor(availableWidth / itemsPerRow)

            return CGSize(width: itemWidth, height: 120)
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 16
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
    

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.collection.collectionViewLayout.invalidateLayout()
        }, completion: nil)
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
