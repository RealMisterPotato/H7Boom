//
//  ScoreHandler.swift
//  H7Boom
//
//  Created by שחר זנגי on 26/04/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

import Foundation

class ScoreHandler{
    public static var publicScore: Int! = 0 // use when need to save the current score between views (believe me it's cool)
    public static var publicLeaderboardDict: [String : Int]? = nil // an array to display leaderboards
        
    public static func getHighScore()->Int{
        var highscore = 0
        if (Helper.loggedInAs() != nil){
            highscore = DatabaseHandler.getUserHighScore(Helper.loggedInAs()!)!
        }
        return highscore
    }
}
