//
//  HomeSport.swift
//  SportsApp
//
//  Created by Macos on 20/05/2025.
//

import Foundation

class HomeSport{
    let title:String
    let playerImg:String
    let backgroundImg:String
    let sport:Sport
    let factory:SportFactory
    
    init(title: String, playerImg: String, backgroundImg: String, sport: Sport, factory: SportFactory) {
        self.title = title
        self.playerImg = playerImg
        self.backgroundImg = backgroundImg
        self.sport = sport
        self.factory = factory
    }
    
}
