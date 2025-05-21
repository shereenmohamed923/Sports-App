//
//  Preseter.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation

class Presenter{
    
    var leaguesDao = LeaguesDAO()
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
    
    func fetchFixtures(sport:Sport,factory:SportFactory){
        network.fetchData(sport: sport, endpoint: .fixture,addOn: "&from=\(DateManger.getPreviousWeekDate())&to=\(DateManger.getNextWeekDate())", completion: {data, error in
            var fixtures=[Fixture]()
            if let error=error{
//                DispatchQueue.main.async {
//                        self.leaguesVC?.showError(message: error.localizedDescription)
//                    }
                    return
            }
            
            for i in data!{
                fixtures.append(factory.createFixture(object: i))
             }
            
        })
    }
    
    //teamId should change to be dynamically handled
    func fetchTeam(sport:Sport,factory:SportFactory){
        network.fetchData(sport: sport, endpoint: .team,addOn: "&teamId=96", completion: {data, error in
            var teams=[Team]()
            if let error=error{
//                DispatchQueue.main.async {
//                        self.leaguesVC?.showError(message: error.localizedDescription)
//                    }
                    return
            }
            
            for i in data!{
                teams.append(factory.createTeam(object: i))
             }
            
        })
    }
    
    //playerId should change to be dynamically handled
    func fetchPlayer(sport:Sport,factory:SportFactory){
        network.fetchData(sport: sport, endpoint: .player,addOn: "&playerId=103051168", completion: {data, error in
            var players=[Player]()
            if let error=error{
//                DispatchQueue.main.async {
//                        self.leaguesVC?.showError(message: error.localizedDescription)
//                    }
                    return
            }
            
            for i in data!{
                players.append(factory.createPlayer(object: i))
             }
        })
    }
    
    func saveLeagueToFavorites(league: League) {
        leaguesDao.saveLeagueToFavorites(league: league)
    }
    
}
