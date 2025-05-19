//
//  SportEnums.swift
//  SportsApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation

enum Sport {
    case football
    case basketball
    case tennis
    case cricket

    var data: String {
        switch self {
        case .football:
            return "football"
        case .basketball:
            return "basketball"
        case .tennis:
            return "tennis"
        case .cricket:
            return "cricket"
        }
    }
}

enum Endpoint {
    case league
    case fixture
    case team
    case player

    var data: String {
        switch self {
        case .league:
            return "football"
        case .fixture:
            return "/?met=Fixtures"
        case .team:
            return "/?&met=Teams"
        case .player:
            return "/?&met=Players"
        }
    }
}
