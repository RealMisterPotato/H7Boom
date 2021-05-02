//
//  IO.swift
//  H7Boom
//
//  Created by שחר זנגי on 13/04/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

// A dank helper class!
import Foundation
import UIKit

class Helper{
    static let CGpi = CGFloat.pi
    static var screenWidth : Double{ return Double(UIScreen.main.bounds.width) }
    static var screenHeight : Double{ return Double(UIScreen.main.bounds.height) }
    
    static let defaults = UserDefaults.standard // userdefaults for saving
    

    // convert degrees to radians
    static func degToRad(_ deg:Double)->Double{
        let rad = CGpi*CGFloat(deg)/180.0
        return Double(rad)
    }
    
    // try to login (true if logged in false if not)
    static func tryLogin(nickname: String, password: String)->Bool?{
        print("Trying to log in as: \(nickname), \(password)")
        var loggedIn = DatabaseHandler.loginDataCorrect(nickname: nickname, password: password)
        defaults.set(nickname, forKey: Keys.loggedAs)
        return loggedIn
    }
    
    //  check if logged in (returns nil if not)
    static func loggedInAs()->String?{
        return defaults.string(forKey: Keys.loggedAs)
    }
    

    // more intuitive class for using colors
    class Color{
        private var r:CGFloat!
        private var g:CGFloat!
        private var b:CGFloat!
        private var a:CGFloat!
        init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat){
            self.r = r
            self.g = g
            self.b = b
            self.a = a
        }
        init(){
            self.r = 0
            self.g = 0
            self.b = 0
            self.a = 0
        }
        func getR()->CGFloat { return r }
        func getG()->CGFloat { return g }
        func getB()->CGFloat { return b }
        func setR(_ r: CGFloat) { self.r = (0 <= r && r <= 1) ? r : self.r}
        func setG(_ g: CGFloat) { self.g = (0 <= g && g <= 1) ? g : self.g}
        func setB(_ b: CGFloat) { self.b = (0 <= b && b <= 1) ? b : self.b}
        func toUIColor()->UIColor{
            return UIColor.init(red: r, green: g, blue: b, alpha: a)
        }
        // generate a random color
        func randomRGBColor(){
            r = CGFloat.random(in: 0...1)
            g = CGFloat.random(in: 0...1)
            b = CGFloat.random(in: 0...1)
            a = 1
        }
        // invert the color
        func invertColor(){
            r = 1 - r
            g = 1 - g
            b = 1 - b
        }
    
        
    }

}
