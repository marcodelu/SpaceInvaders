//
//  LevelManager.swift
//  SpaceInvaders
//
//  Created by Marco De Lucchi on 11/05/16.
//  Copyright © 2016 Marco De Lucchi. All rights reserved.
//

import Foundation
import SpriteKit

struct LevelDetails {
    private var texture: SKTexture
    private var speed: Float
    private var rows: Int
    private var invadersInRow: Int
    
    init(texture: Int, speed: Float, rows: Int) {
        self.texture = SKTexture(imageNamed: "invader" + String(texture))
        self.speed = speed
        self.rows = rows
        invadersInRow = 5
        
    }
}

class LevelManager {
    private static let level1 = LevelDetails(texture: 1, speed: 1, rows: 2)
    private static let level2 = LevelDetails(texture: 2, speed: 1.2, rows: 3)
    private static let level3 = LevelDetails(texture: 3, speed: 1.5, rows: 4)
    private static let level4 = LevelDetails(texture: 4, speed: 2, rows: 5)
    
    private static var levelArray: [LevelDetails] = [level1, level2, level3, level4]
    
    static var level: Int = 1
    static let maxLevel: Int = 4
    
    
    static var texture: SKTexture{
        return levelArray[level-1].texture
    }
    static var speed: Float{
        return levelArray[level-1].speed
    }
    static var rows: Int{
        return levelArray[level-1].rows
    }
    static var invadersInRow: Int{
        return levelArray[level-1].invadersInRow
    }
    
    static func nextLevel() {
        level += 1
        if (level > maxLevel) {
            level = maxLevel
        }
    }
    
    static func changeDirection() {
        levelArray[level-1].speed *= -1
    }
    
    static func newGame(){
        level = 1
    }
}