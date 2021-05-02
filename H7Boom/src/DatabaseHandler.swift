//
//  DatabaseHandler.swift
//  H7Boom
//
//  Created by שחר זנגי on 30/04/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

import Foundation
import Firebase

class DatabaseHandler{
    
    private static let requestTime : TimeInterval = 5 // maximum wait time for request in seconds
    
    private static var ref = Database.database(url: "https://h7boom-81b88-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    public static func createUser(nickname: String, password: String){
        
        let p = Player.init(nickname: nickname, password: password, highScore: 0)
        
    
        DatabaseHandler.ref.child("passwords/\(String(p.nickname))/\(String(p.password))").setValue(1)
        DatabaseHandler.ref.child("players/\(String(p.nickname))").setValue(p.highScore)
    }
    public static func userExists(_ nickname: String)-> Bool?{
        var exists: Bool?
        DatabaseHandler.ref.child("players/\(String(nickname))").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
                exists = true
            }
            else if snapshot.exists(){
                print("Got data: \(snapshot.value)")
                exists = true
            }
            else{
                print("No data available")
                exists = false
            }
        }
        let startTime = Date().timeIntervalSince1970
        while exists == nil{
            var curTime = Date().timeIntervalSince1970
            if (curTime - startTime > DatabaseHandler.requestTime){
                break
            }
        }
        return exists
    }
    public static func getUserHighScore(_ nickname: String)->Int?{
        var highscore: Int?
        DatabaseHandler.ref.child("players/\(nickname)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
                highscore = -1
            }
            else if snapshot.exists(){
                print("Got data: \(snapshot.value)")
                highscore = snapshot.value! as? Int ?? 0
            }
            else{
                print("No data available")
                highscore = -1
            }
        }
        let startTime = Date().timeIntervalSince1970
        while highscore == nil{
            var curTime = Date().timeIntervalSince1970
            if (curTime - startTime > DatabaseHandler.requestTime){
                break
            }
        }
        return highscore
    }
    public static func updateHighScore(_ highScore: Int){
        DatabaseHandler.ref.child("players/\(String(Helper.loggedInAs()!))").setValue(highScore)
    }
    public static func loginDataCorrect(nickname: String, password: String) -> Bool?{
       
        var correct : Bool?
    
        DatabaseHandler.ref.child("passwords/\(String(nickname))/\(String(password))").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                    correct = false
                }
                else if snapshot.exists(){
                    print("Got data: \(snapshot.value)")
                    correct = true
                }
                else{
                    print("No data available")
                    correct = false
                }
        }
        let startTime = Date().timeIntervalSince1970
        while correct == nil{
            var curTime = Date().timeIntervalSince1970
            if (curTime - startTime > DatabaseHandler.requestTime){
                break
            }
        }
        return correct
    }
    
    public static func updateLeaderboardsArray(){
        var finished = false
            DatabaseHandler.ref.child("players").getData { (error, snapshot) in
                    if let error = error {
                        print("Error getting data \(error)")
                        ScoreHandler.publicLeaderboardDict = nil
                    }
                    else if snapshot.exists(){
                        print("Got data: \(snapshot.value)")
                        ScoreHandler.publicLeaderboardDict = snapshot.value as! [String: Int]
                    }
                    else{
                        print("No data available")
                        ScoreHandler.publicLeaderboardDict = nil
                    }
                finished = true
            }
            let startTime = Date().timeIntervalSince1970
            while !finished{
                var curTime = Date().timeIntervalSince1970
                if (curTime - startTime > DatabaseHandler.requestTime){
                    break
                }
            }
    }
    
}
