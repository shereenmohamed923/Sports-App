//
//  Preseter.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation

class Presenter{
    
    var network:NetworkService
    var leaguesVC: LeaguesTableViewController?

    init(leaguesVC: LeaguesTableViewController) {
        self.network = NetworkService()
        self.leaguesVC = leaguesVC
    }
    
    func fetchLeagues(sport:Sport,factory:SportFactory){
        network.fetchData(sport: sport, endpoint: .league,addOn: "&teamId=2616", completion: {data, error in
            var leagues=[League]()
            if let error=error{
                DispatchQueue.main.async {
                        self.leaguesVC?.showError(message: error.localizedDescription)
                    }
                    return
            }
            
            for i in data!{
                 leagues.append(factory.createLeague(object: i))
             }
            
            self.leaguesVC?.leagues = leagues
            DispatchQueue.main.async {
                self.leaguesVC?.reload()
            }
        })
    }
    
}
