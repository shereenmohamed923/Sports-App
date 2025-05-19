//
//  LeagueFactory.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation

protocol SportFactory{
    func createLeague(object:[String:Any]) -> League
    
    func createFixture(object:[String:Any]) -> Fixture
    
    func createTeam(object:[String:Any]) -> Team
    
    func createPlayer(object:[String:Any]) -> Player
}
