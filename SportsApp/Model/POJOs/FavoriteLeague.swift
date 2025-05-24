//
//  LeagueEntity.swift
//  SportsApp
//
//  Created by Macos on 24/05/2025.
//

import Foundation

class FavoriteLeague{
    let key:Int?
    let name:String?
    let img:String?
    let sport: String?
    init(key: Int?, name: String?, img: String?, sport: String?) {
        self.key = key
        self.name = name
        self.img = img
        self.sport = sport
    }
}

