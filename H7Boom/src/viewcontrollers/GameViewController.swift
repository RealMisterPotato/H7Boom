//
//  GameViewController.swift
//  H7Boom
//
//  Created by שחר זנגי on 19/04/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

import Foundation
import UIKit

class GameViewController : UIViewController{
    private var gameTimer:Timer?
    private var timerCounter:Int!
    private var count:Int!
    private var score:Int!
    private var timeLeft:Int!
    private var gameStarted:Bool!
    
    // min and max values for time left
    private let minTime = 3
    private let maxTime = 10
 
    @IBOutlet weak var counterLabel: CounterLabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var counterLabelTop: NSLayoutConstraint!
    @IBOutlet weak var counterLabelLeft: NSLayoutConstraint!
    

    private func endGame(){
        print("Game ended with score of: \(String(score))")
        ScoreHandler.publicScore = score
        gameTimer?.invalidate()
        performSegue(withIdentifier: "endGameSegue", sender: self)
    }
    private func gameLoop(){

        counterLabel.update()
        counterLabel.text = (count == 0) ? "Click here to start!" : String(count)
        
        if (timerCounter == 10){
            // 1 second had passed
            if gameStarted {
                timeLeft -= 1
                timeLeftLabel.text = "Time left: \(self.timeLeft!) seconds"
            }
            timerCounter = 0 // reset timer counter
        }
        self.timerCounter += 1
        
        if (timeLeft <= 0){ endGame() }
    }
    public func resetGame(){
        timerCounter = 0
        count = 1
        score = 0
        timeLeft = 1
        gameStarted = false
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ timer in
            self.gameLoop()
        }
    }

    private func calculateTimeLeft()->Int{
        let timeleft = minTime+(count/10)*2
        return (timeleft <= maxTime) ? timeleft : maxTime
    }

    private func randomizeColors(){
        let color = Helper.Color.init()
        color.randomRGBColor() // generate a random color
        self.view.backgroundColor = color.toUIColor() // main background
        timeLeftLabel.textColor = color.toUIColor() // timeleft text
        color.invertColor() // invert the color
        counterLabel.textColor = color.toUIColor() // counter text
        timeLeftLabel.backgroundColor = color.toUIColor() // timeleft background
    }
    private func increaseScore(didBoom: Bool){
        var incScore = count*timeLeft // score calculation
        incScore *= didBoom ? 2 : 1 // double points for boom
        score += (incScore == 0) ? 1 : incScore
        // visual stuff
        randomizeColors()
        count += 1
        counterLabel.push(directionRads: Helper.degToRad(Double.random(in: 0...359)), intensity: Double.random(in: 0...50))
        
        timeLeft = calculateTimeLeft()
    }
    @objc func counterClicked(sender: UIGestureRecognizer){
        let justified = (count % 7 == 0 || String(count).contains("7"))
        if (justified){ // a boom is justified
            increaseScore(didBoom: true)
        }
        else if gameStarted{ // Prevents misclicks on the counter if the game didn't start
            endGame()
        }
        //print("counter was clicked")
    }
    @objc func backgroundClicked(){
        let justified = !(count % 7 == 0 || String(count).contains("7"))
        if (justified){
            increaseScore(didBoom: false)
        }
        else{
            endGame()
        }
        //print("counter was not clicked")
        if !gameStarted { gameStarted = true }
    }
    override func viewDidLoad(){
        // Do work after the view was loaded
        super.viewDidLoad()
        
        resetGame()
        
        counterLabel.setConstraints(counterLabelTop, counterLabelLeft)
        
        // tap recognizers for counter and
        let counterTapRec = UITapGestureRecognizer(target: self, action: #selector(GameViewController.counterClicked)) // gesture recognizer for counterLabel click
        let generalTapRec = UITapGestureRecognizer(target: self, action: #selector(GameViewController.backgroundClicked))
        
        counterLabel.isUserInteractionEnabled = true
        self.view.isUserInteractionEnabled = true
        
        counterLabel.addGestureRecognizer(counterTapRec) // add the recognizer
        self.view.addGestureRecognizer(generalTapRec)
        
        

    }
}
