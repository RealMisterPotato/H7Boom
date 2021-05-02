//
//  ViewController.swift
//  Hardcore7Boom
//
//  Created by שחר זנגי on 11/04/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var leaderboardsButton: UIButton!
    
    var textAnimationTimer:Timer?
    
    private func animateHeadline(){
        let animationIntensity = 0.3
        let maxDeg = 20.0
        let baseDistance = 70.0
        let maxDistance = 90.0
        let epochTime = Date().timeIntervalSince1970
        textLabelTop.constant = CGFloat(baseDistance + cos(epochTime)*maxDistance*animationIntensity)
        textLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Helper.degToRad((-maxDeg/2 + cos(epochTime*2.37)*maxDeg)*animationIntensity)))
    }
    private func updateLoginbButton(){
        loginButton.setTitle(Helper.loggedInAs() != nil ? "Logged in as: \(Helper.loggedInAs()!)" : "Login", for: UIControl.State.normal)
    }
    private func restartTimer(){
        textAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ timer in
            self.animateHeadline()
            self.loginButton.setTitle(Helper.loggedInAs() != nil ? "Logged in as: \(Helper.loggedInAs()!)" : "Login", for: UIControl.State.normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        restartTimer()
        // add gradient layer
        let gradLayer = CAGradientLayer()
        gradLayer.frame = self.view.bounds
        gradLayer.colors = [UIColor.cyan.cgColor, UIColor.purple.cgColor]
        self.view.layer.insertSublayer(gradLayer, at: 0)
    }
    
    private func logout(alert: UIAlertAction!){
        Helper.defaults.set(nil, forKey: Keys.loggedAs)
    }
    @IBAction func loginClicked(_ sender: Any) {
        if (Helper.loggedInAs() == nil){
            performSegue(withIdentifier: "loginSegue", sender: self)
        } else{
            // show sign out dialog
            let alert = UIAlertController(title: "Log out?", message: "Log out from player: \(Helper.loggedInAs()!)?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: logout))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: false, completion: nil)
        }
    }
    @IBAction func playClicked(_ sender: Any) {
        var gameVC = UIStoryboard(name: "Game", bundle: nil).instantiateViewController(withIdentifier: "gameViewController") as UIViewController // initiate viewcontrolelr
        gameVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(gameVC, animated: false, completion: nil)

    }
    @IBAction func leaderboardsClicked(_ sender: Any) {
        DatabaseHandler.updateLeaderboardsArray()
        performSegue(withIdentifier: "leaderboardsSegue", sender: self)
    }
    @IBAction func howToPlayClicked(_ sender: Any) {
        performSegue(withIdentifier: "howToPlaySegue", sender: self)
    }
    override func viewWillAppear(_ animated:Bool){
        // called when the view is about to appear
        guard let textAnimationTimer = textAnimationTimer else { return}
        if !textAnimationTimer.isValid { self.restartTimer() }
        
        updateLoginbButton()

    }
    override func viewWillDisappear(_ animated:Bool){
        // called when the view is about to disappear
        guard let textAnimationTimer = textAnimationTimer else { return}
        textAnimationTimer.invalidate()
    }


}

