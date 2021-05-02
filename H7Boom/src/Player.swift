//
//  Player.swift
//  H7Boom
//
//  Created by שחר זנגי on 30/04/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

import Foundation

class Player{
    
    var nickname: String!
    var password: String!
    var highScore: Int!
    
    init(nickname: String, password: String, highScore: Int){
        self.nickname = nickname
        self.password = password
        self.highScore = highScore
    }
}
