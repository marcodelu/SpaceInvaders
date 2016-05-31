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
    
    static func newGame() {
        level = 1
        texture = 1
        speed = 1
        rows = 2
        invadersInRow = 5
        score = 0
    }
    
    static func nextLevel() {
        print("Level changed")
        level += 1
        texture += 1
        speed += 0.5
        rows += 1
        invadersInRow = 5
    }
    
    static func changeDirection() {
        speed *= -1
    }
    
    static func getTexture() -> SKTexture{
        return SKTexture(imageNamed: "invader" + String(texture))
    }
    
    static func saveScore(s: Int){
        score = s
        print("Saved score: \(score)")
    }
    
    static func restoreScore() -> Int{
        print("Restored score: \(score)")
        return score
    }

}