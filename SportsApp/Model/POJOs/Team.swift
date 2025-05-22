//
//  Team.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation

class Team{
    let key:Int?
    let name:String?
    let img:String?
    var players:[Player]?
    let coach:String?
    
    init(key: Int?, name: String?, img: String?, players: [Player]?, coach: String?) {
        self.key = key
        self.name = name
        self.img = img
        self.players = players
        self.coach = coach
    }
}
