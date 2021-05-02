//
//  File.swift
//  H7Boom
//
//  Created by שחר זנגי on 19/04/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

import Foundation
import UIKit

class CounterLabel : UILabel{
    public var value : Int! = 1
    private var x : Double! = Helper.screenWidth/2 // position
    private var y : Double! = Helper.screenHeight/2 // position
    private var velX : Double! = 0.0
    private var velY : Double! = 0.0
    private var friction : Double! = 0.8 // multiply velocity by it
    
    private var constraintTop : NSLayoutConstraint?
    private var constraintLeft : NSLayoutConstraint?
    
    private let screenOffset : Double! = 64.0 // offset to check to keep in screen
    
    public func getX()->Double{ return self.x }
    public func getY()->Double{ return self.y }
    public func push(directionRads: Double, intensity: Double){
        // calculate velX and velY
        self.velX = intensity*cos(directionRads)
        self.velY = self.velX*tan(directionRads)
    }
    public func setConstraints(_ constraintTop: NSLayoutConstraint, _ constraintLeft: NSLayoutConstraint){
        self.constraintTop = constraintTop
        self.constraintLeft = constraintLeft
    }
    private func applyPosition()->Bool{
        if self.constraintTop == nil || self.constraintLeft == nil {return false}
        self.constraintTop!.constant = CGFloat(self.y)
        self.constraintLeft!.constant = CGFloat(self.x)
        return true
        
    }
    private func applyValue(){
        self.text = String(self.value)
    }
    private func keepInScreen(){
        if (self.x > Helper.screenWidth - Double(self.bounds.width)){
            self.x = Helper.screenWidth - Double(self.bounds.width)
            self.velX *= -1
        }else if (self.x < 0) {
            self.x = 0
            self.velX *= -1
        }
        
        if (self.y > Helper.screenHeight - Double(self.bounds.height) - screenOffset ){
            self.y = Helper.screenHeight - Double(self.bounds.height) - screenOffset
            self.velY *= -1
        } else if (self.y < 0) {
            self.y = 0
            self.velY *= -1
        }
        print("Y engage in: \(self.y - Helper.screenHeight - Double(self.bounds.height))")
    }
    public func update(){
        self.x += self.velX
        self.y += self.velY
        self.keepInScreen()
        if(!self.applyPosition()){print("Constraints not set in CounterLabel")}
        self.applyValue()
        self.velX *= self.friction
        self.velY *= self.friction
    }
}
