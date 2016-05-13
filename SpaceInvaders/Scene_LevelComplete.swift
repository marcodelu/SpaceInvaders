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
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.blackColor()
        let backgroud = SKEmitterNode(fileNamed: "Backgroud_StartGame")
        backgroud!.position = CGPointMake(size.width/2,size.height+10)
        backgroud!.zPosition = -1000
        addChild(backgroud!)
        
        let startGameButton = SKSpriteNode(imageNamed: "NextLevel")
        startGameButton.position = CGPointMake(size.width/2,size.height/2 - 100)
        startGameButton.name = "nextlevel"
        addChild(startGameButton)
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
