//
//  LevelManager.swift
//  SpaceInvaders
//
//  Created by Marco De Lucchi on 11/05/16.
//  Copyright © 2016 Marco De Lucchi. All rights reserved.
//

import Foundation
import SpriteKit

class LevelManager {
    static private(set) var speed: Float = 1
    static private(set) var rows: Int = 1
    static private(set) var invadersInRow: Int = 1
    static private var texture: Int = 1

    static private(set) var level: Int = 1
    static private(set) var maxLevel: Int = 10
    
    static private var score = 0;
    static private var highscore = 0;
    
    static func newGame() {
        level = 1
        texture = 1
        speed = 1
        rows = 1
        invadersInRow = 5
        score = 0
    }
    
    static func nextLevel() {
        if speed<0 {
            speed *= -1
        }
        
        level += 1
        texture += 1
        speed += 0.3
        rows += 1
        invadersInRow = 5
        
        if(level>=5) {
            speed -= 0.3
        }
        
        if(level>8) {
            texture = 8
        }
        
        print("Level: ", level, " speed:", speed, " rows: ", rows)
    }
    
    static func changeDirection() {
        speed *= -1
        //print("Changed direction: ", speed)
    }
    
    static func getTexture() -> String{
        return String(texture)
    }
    
    static func saveScore(s: Int){
        score = s
        
        if score > highscore{
            //print("in LevelManager changed hs: ", highscore, " score: ", score)
            highscore = score
        }
    }
    
    static func restoreScore() -> Int{
        return score
    }
    
    static func setHighscore(s: Int){
        highscore = s
        //print("set hs: ", highscore)
    }
    
    static func getHighscore() -> Int{
        //print("get hs: ", highscore)
        return highscore
    }

}