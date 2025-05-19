//
//  BasketballFactory.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation

class BasketballFactory:SportFactory{
    func createLeague(object: [String : Any]) -> League {
        return League(key: object["league_key"] as? String, name: object["league_name"] as? String, img: nil)
    }
    
    func createFixture(object: [String : Any]) -> Fixture {
        return Fixture(date: object["event_date"] as? String, time: object["event_time"] as? String, home: object["event_home_team"] as? String, away: object["event_away_team"] as? String, homeImg: object["home_team_logo"] as? String, awayImg: object["away_team_logo"] as? String, result: object["event_final_result"] as? String)
    }
    
    func createTeam(object: [String : Any]) -> Team {
        return Team(key: object["team_key"] as? String, name: object["team_name"] as? String, img: object["team_logo"] as? String, players: nil, coach: nil)
    }
    
    internal func createPlayer(object: [String : Any]) -> Player {
        return Player(name: object["player_name"] as? String, number: ["player_number"] as? String, image: object["player_image"] as? String, pos: object["player_type"] as? String)
    }
    
    
}
