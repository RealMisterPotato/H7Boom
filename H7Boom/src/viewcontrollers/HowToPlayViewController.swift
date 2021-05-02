//
//  HowToPlayController.swift
//  H7Boom
//
//  Created by שחר זנגי on 27/04/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

import Foundation
import UIKit

class HowToPlayViewController : UIViewController{
    
    @IBOutlet weak var guideLabel: UILabel!
    private let dialogs =   ["7 Boom.",
                             "Your mission:",
                             "Survive.",
                             "How do you do it?",
                             "If the number you are seeing is divisible by 7,",
                             "OR",
                             "the number contains the digit \"7\"",
                             "You MUST blow it up! 💥",
                             "How do you do it? 🧐",
                             "Just click on it, it's not an FPS game 😂",
                             "But wait❗️There is more 😎",
                             "What if the number doesn't meet the criteria? 😮",
                             "Just click anywhere else LOL 😎👌",
                             "Your score will be higher the faster you play.",
                             "That's it for now! Have a nice time playing!"
                            ]
    private var counter : Int! = 0
    
    private func randomizeColors(){
        let color = Helper.Color.init()
        color.randomRGBColor() // generate a random color
        self.view.backgroundColor = color.toUIColor() // background
        color.invertColor() // invert the color
        guideLabel.textColor = color.toUIColor() // text
    }
    
    private func endTutorial(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func click(){
        // user clicked the screen
        if counter < dialogs.count{
            guideLabel.text = dialogs[counter]
            randomizeColors()
            counter += 1
        }
        else{
            endTutorial()
        }
    }
    override func viewDidLoad(){
        // Do work after the view was loaded
        super.viewDidLoad()
        
        let tapRec = UITapGestureRecognizer(target: self, action: #selector(HowToPlayViewController.click))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapRec)
    }
}
