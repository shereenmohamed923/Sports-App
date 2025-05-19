//
//  Player.swift
//  SportsApp
//
//  Created by Macos on 18/05/2025.
//

import Foundation

class Player{
     let name:String?
     let number:String?
     let image:String?
    let pos:String?
    
    init(name: String?, number: String?, image: String?, pos:String?) {
        self.name = name
        self.number = number
        self.image = image
        self.pos=pos
    }
}
