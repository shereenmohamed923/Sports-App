//
//  League.swift
//  SportsApp
//
//  Created by Macos on 18/05/2025.
//

import Foundation

class Fixture{
    let date: String?
    let time: String?
    let home: String?
    let away: String?
    let homeImg: String?
    let awayImg: String?
    let result: String?
    
    init(date: String?, time: String?, home: String?, away: String?, homeImg: String?, awayImg: String?, result: String?) {
        self.date = date
        self.time = time
        self.home = home
        self.away = away
        self.homeImg = homeImg
        self.awayImg = awayImg
        self.result = result
    }
    

}
