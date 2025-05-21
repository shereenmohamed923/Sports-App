//
//  TennisFactory.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation

class TennisFactory:SportFactory{
    func createLeague(object: [String : Any]) -> League {
        return League(key: object["league_key"] as? Int, name: object["league_name"] as? String, img: "")
    }
    
    func createFixture(object: [String : Any]) -> Fixture {
        return Fixture(date: object["event_date"] as? String, time: object["event_time"] as? String, home: object["event_first_player"] as? String, away: object["event_second_player"] as? String, homeImg: object["event_first_player_logo"] as? String, awayImg: object["event_second_player_logo"] as? String, result: object["event_final_result"] as? String)
    }
    
    func createTeam(object: [String : Any]) -> Team {
        return Team(key: object["player_key"] as? String, name: object["player_name"] as? String, img: object["player_logo"] as? String, players: nil, coach: nil)
    }
    
    internal func createPlayer(object: [String : Any]) -> Player {
        return Player(name: object["player_name"] as? String, number: nil, image: object["player_logo"] as? String, pos: nil)
    }
    
    
}
