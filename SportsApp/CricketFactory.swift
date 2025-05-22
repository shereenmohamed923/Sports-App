//
//  CricketFactory.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation

class CricketFactory:SportFactory{
    func createLeague(object: [String : Any]) -> League {
        return League(key: object["league_key"] as? Int, name: object["league_name"] as? String, img: "")
    }
    
    func createFixture(object: [String : Any]) -> Fixture {
        return Fixture(date: object["event_date_start"] as? String, time: object["event_time"] as? String, home: object["event_home_team"] as? String, away: object["event_away_team"] as? String, homeImg: object["event_home_team_logo"] as? String, awayImg: object["event_away_team_logo"] as? String, result: object["event_home_final_result"] as? String)
    }
    
    func createTeam(object: [String : Any]) -> Team {
        return Team(key: object["team_key"] as? Int, name: object["team_name"] as? String, img: object["team_logo"] as? String, players: nil, coach: nil)
    }
    
    func createPlayer(object: [String : Any]) -> Player {
        return Player(name: object["team_name"] as? String, number: nil, image: object["team_logo"] as? String, pos: nil)
    }
}
