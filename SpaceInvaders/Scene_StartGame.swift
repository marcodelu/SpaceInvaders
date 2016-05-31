//
//  Scene_StartGame.swift
//  SpaceInvaders
//
//  Created by Marco De Lucchi on 08/05/16.
//  Copyright © 2016 Marco De Lucchi. All rights reserved.
//

import UIKit
import SpriteKit

class Scene_StartGame: SKScene {
    var colortime: Int = 0
    let Title1 = SKLabelNode(fontNamed: "Space Invaders")
    let Title2 = SKLabelNode(fontNamed: "Space Invaders")
    let Start = SKLabelNode(fontNamed: "Space Invaders")
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.blackColor()
        let backgroud = SKEmitterNode(fileNamed: "Backgroud_StartGame")
        backgroud!.position = CGPointMake(size.width/2,size.height+10)
        backgroud!.zPosition = -1000
        addChild(backgroud!)
        
        
        Title1.text = "SPACE"
        Title1.position = CGPointMake(size.width/2, size.height/2+75)
        Title1.fontSize = 55
        Title1.color = SKColor.whiteColor()
        Title1.name = "title1"
        
        Title2.text = "INVADERS"
        Title2.position = CGPointMake(size.width/2, size.height/2+20)
        Title2.fontSize = 55
        Title2.color = SKColor.whiteColor()
        Title2.name = "title2"
        
        Start.text = "NEW GAME"
        Start.position = CGPointMake(size.width/2, size.height/2 - 170)
        Start.fontSize = 40
        Start.color = SKColor.whiteColor()
        Start.name = "start"
        
        /*let StartBox = SKShapeNode(rectOfSize: CGSize(width: 100, height: 50))
        StartBox.position = CGPointMake(Start.position.x-10, Start.position.y)*/
        
        /*let Title = SKSpriteNode(imageNamed: "Title")
        Title.position = CGPointMake(size.width/2-100, size.height/2)
        let Button_start = SKSpriteNode(imageNamed: "NewGame")
        Button_start.position = CGPointMake(size.width/2,size.height/2 - 150)
        Button_start.name = "start"*/
        
        addChild(Title1)
        addChild(Title2)
        addChild(Start)
        //addChild(StartBox)
        
        runAction(SKAction.repeatActionForever(changeColor()))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        let touchLocation = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        if touchedNode.name == "start" {
            LevelManager.newGame()
            let newScene = Scene_Game(size: size)
            newScene.scaleMode = scaleMode
            let transitionType = SKTransition.doorsOpenHorizontalWithDuration(1.0)
            view?.presentScene(newScene,transition: transitionType)
        }
    }
    
    func changeColor() -> SKAction{
        let change = SKAction.runBlock {
            self.colortime += 1
            
            switch self.colortime {
            case 1:
                self.Title1.fontColor = SKColor.redColor()
                self.Title2.fontColor = SKColor.redColor()
                self.Start.fontColor = SKColor.redColor()
                break
            case 2:
                self.Title1.fontColor = SKColor.greenColor()
                self.Title2.fontColor = SKColor.greenColor()
                self.Start.fontColor = SKColor.greenColor()
                break
            case 3:
                self.Title1.fontColor = SKColor.blueColor()
                self.Title2.fontColor = SKColor.blueColor()
                self.Start.fontColor = SKColor.blueColor()
                break
            case 4:
                self.Title1.fontColor = SKColor.yellowColor()
                self.Title2.fontColor = SKColor.yellowColor()
                self.Start.fontColor = SKColor.yellowColor()
                break
            case 5:
                self.Title1.fontColor = SKColor.orangeColor()
                self.Title2.fontColor = SKColor.orangeColor()
                self.Start.fontColor = SKColor.orangeColor()
                break
            case 6:
                self.Title1.fontColor = SKColor.purpleColor()
                self.Title2.fontColor = SKColor.purpleColor()
                self.Start.fontColor = SKColor.purpleColor()
                break

            default:
                self.Title1.fontColor = SKColor.whiteColor()
                self.Title2.fontColor = SKColor.whiteColor()
                self.Start.fontColor = SKColor.whiteColor()
                self.colortime = 0
                break
            }
        }
        let wait = SKAction.waitForDuration(1)
        let sequence = SKAction.sequence([change, wait])
        return sequence
    }

}
