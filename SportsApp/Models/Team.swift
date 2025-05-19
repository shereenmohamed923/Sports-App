//
//  Team.swift
//  SportsApp
//
//  Created by Macos on 18/05/2025.
//

import Foundation

class Team{
    let key:String?
    let name:String?
    let img:String?
    var players:[Player]?
    let coach:String?
    
    init(key: String?, name: String?, img: String?, players: [Player]?, coach: String?) {
        self.key = key
        self.name = name
        self.img = img
        self.players = players
        self.coach = coach
    }
}
