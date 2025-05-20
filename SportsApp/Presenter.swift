//
//  Preseter.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation

/*class Presenter{
    
    var network:NetworkService
    
    var leagues:[League]{
        didSet{
        }
    }
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func fetchLeagues(sport:Sport,factory:SportFactory){
        network.fetchData(sport: sport, endpoint: .league,addOn: "&teamId=2616", completion: {data, error in
            var leagues=[League]()
            if let error=error{
                return
            }
            for i in data!{
                 leagues.append(factory.createLeague(object: i))
             }
             self.leagues=leagues
        })
    }
    
}*/
