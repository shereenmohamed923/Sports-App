//
//  Preseter.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation

class Presenter{
    
    var network:NetworkService
    var dataHandle: DataHandling

    init(dataHandle: DataHandling) {
        self.network = NetworkService()
        self.dataHandle = dataHandle
    }
    
    func fetchLeagues(sport:Sport, factory:SportFactory){
        network.fetchData(sport: sport, endpoint: .league, completion: {data, error in
            var leagues=[League]()
            if let error=error{
                self.dataHandle.showError(error: error)
                return
            }
            
            for i in data!{
                leagues.append(factory.createLeague(object: i))
            }
            let data=["leagues":leagues]
            self.dataHandle.getData(data:data)
        })
    }
    
    func fetchFixtures(sport:Sport, factory:SportFactory, addOn:String){
        network.fetchData(sport: sport, endpoint: .fixture,addOn: "&from=\(DateManger.getPreviousWeekDate())&to=\(DateManger.getNextWeekDate())"+addOn, completion: {data, error in
            var fixtures=[Fixture]()
            if let error=error{
                self.dataHandle.showError(error: error)
                    return
            }
            
            for i in data!{
                fixtures.append(factory.createFixture(object: i))
             }
            let data=["fixtures":fixtures]
            self.dataHandle.getData(data:data)
        })
    }
    
    func fetchTeam(sport:Sport, factory:SportFactory, addOn:String){
        network.fetchData(sport: sport, endpoint: (sport == .tennis) ? .player : .team,addOn: addOn, completion: {data, error in
            var teams=[Team]()
            if let error=error{
                self.dataHandle.showError(error: error)
                    return
            }
            
            for i in data!{
                teams.append(factory.createTeam(object: i))
             }
            let data=["teams":teams]
            self.dataHandle.getData(data:data)
        })
    }
    
}
