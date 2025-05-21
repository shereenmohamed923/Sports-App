//
//  FavoritePresenter.swift
//  SportsApp
//
//  Created by Macos on 21/05/2025.
//

import Foundation

class FavoritePresenter {
    
    var favoritesVC: FavoritesTableViewController?
    var leaguesDao = LeaguesDAO()
    
    init(favoritesVC: FavoritesTableViewController) {
        self.favoritesVC = favoritesVC
    }
    
    func fetchFavoriteLeagues() {
        let favoriteLeagues = leaguesDao.fetchFavoriteLeagues()
        DispatchQueue.main.async {
            self.favoritesVC?.leagues = favoriteLeagues
            self.favoritesVC?.reload()
        }
    }
    
    func deleteLeagueFromFavorites(key: Int) {
        leaguesDao.deleteLeagueFromFavorites(key: key)
        fetchFavoriteLeagues()
    }
}
