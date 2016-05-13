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
    static private(set) var texture: Int = 1
    
    static private(set) var level: Int = 1
    static private(set) var maxLevel: Int = 10
    
    static func newGame() {
        level = 1
        texture = 1
        speed = 1
        rows = 2
        invadersInRow = 6
    }
    
    static func nextLevel() {
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

}