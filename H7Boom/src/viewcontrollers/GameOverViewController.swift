//
//  File.swift
//  H7Boom
//
//  Created by שחר זנגי on 28/04/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

import Foundation
import UIKit

class GameOverViewController : UIViewController{
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    private var highScoreAnimationTimer:Timer?
    private var p: GameViewController?
    private var clickedRetry = false
    
    @IBAction func exitPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func retryPressed(_ sender: Any) {
        guard let p = p else { print("lel");  return }
        p.resetGame()
        clickedRetry = true
        self.dismiss(animated: false, completion: nil)
    }
    private func animateHighscoreLabel(){
        let animationIntensity = 0.3
        let maxDeg = 20.0
        let epochTime = Date().timeIntervalSince1970
        highScoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Helper.degToRad((-maxDeg/2 + cos(epochTime*2.37)*maxDeg)*animationIntensity)))
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        p = self.presentingViewController as? GameViewController
        scoreLabel.text = String(ScoreHandler.publicScore)
        if (Helper.loggedInAs() != nil){
            var userhighscore = DatabaseHandler.getUserHighScore(Helper.loggedInAs()!)
            if (userhighscore != nil){
                if ( userhighscore == -1){
                // disconnected
                }
                else if (userhighscore! < ScoreHandler.publicScore){
                    print("new highscore set: \(userhighscore) < \(ScoreHandler.publicScore)")
                    DatabaseHandler.updateHighScore(ScoreHandler.publicScore)
                    // show the "new highscore" label and animate it
                    highScoreAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
                        self.animateHighscoreLabel()
                        })
                }
            }

        }
    }
    override func viewWillDisappear(_ animated: Bool){
        guard let p = p else { return }
        if (!clickedRetry) {
            p.dismiss(animated: false, completion: nil)
        }
    }
}
