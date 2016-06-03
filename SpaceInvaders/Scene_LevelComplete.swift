//
//  Scene_LevelComplete.swift
//  SpaceInvaders
//
//  Created by Marco De Lucchi on 08/05/16.
//  Copyright © 2016 Marco De Lucchi. All rights reserved.
//

import Foundation
import SpriteKit

class Scene_LevelComplete:SKScene{
    var input: [SKNode]?
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.blackColor()
        let backgroud = SKEmitterNode(fileNamed: "Backgroud_StartGame")
        backgroud!.position = CGPointMake(size.width/2,size.height+10)
        backgroud!.zPosition = -1000
        addChild(backgroud!)
        
        let startGameButton = SKLabelNode(fontNamed: "Space Invaders")
        startGameButton.text = "NEXT LEVEL"
        startGameButton.position = CGPointMake(size.width/2, size.height/2 - 170)
        startGameButton.fontSize = 40
        startGameButton.color = SKColor.whiteColor()
        startGameButton.name = "nextlevel"

        addChild(startGameButton)
        //addChild(input![0])
        //addChild(input![1])
        //addChild(input![2])
        //addChild(input![3])
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        let touchLocation = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        if(touchedNode.name == "nextlevel"){
            let gameOverScene = Scene_Game(size: size)
            gameOverScene.scaleMode = scaleMode
            let transitionType = SKTransition.doorsOpenHorizontalWithDuration(1.0)
            view?.presentScene(gameOverScene,transition: transitionType)
        }
    }
}
