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
    let HighscoreLabel = SKLabelNode(fontNamed: "Space Invaders")
    let HighscoreDefaultText: String = "HIGH SCORE: "
    var HighscoreValue: Int?
    
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
        
        HighscoreLabel.text = HighscoreDefaultText
        HighscoreLabel.position = CGPointMake(size.width/2, 20)
        HighscoreLabel.fontSize = 15
        HighscoreLabel.color = SKColor.whiteColor()
        HighscoreLabel.name = "highscorelabel"
        
        //Restore highscore
        HighscoreValue = NSUserDefaults.standardUserDefaults().objectForKey("highscore") as? Int
        if HighscoreValue != nil {
            HighscoreLabel.text = HighscoreDefaultText + String(HighscoreValue!)
        } else {
            HighscoreValue = 0
            HighscoreLabel.text = HighscoreDefaultText + "0"
        }
        print("High score loaded: ", HighscoreValue)
        LevelManager.setHighscore(HighscoreValue!)
        
        addChild(Title1)
        addChild(Title2)
        addChild(Start)
        addChild(HighscoreLabel)
        
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

        //Resetto high score, solo per test
        print(touches.count)
        if touches.count>=3 {
            HighscoreValue = 0
            LevelManager.setHighscore(HighscoreValue!)
            HighscoreLabel.text = HighscoreDefaultText + String(HighscoreValue!)
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
                self.HighscoreLabel.fontColor = SKColor.redColor()
                break
            case 2:
                self.Title1.fontColor = SKColor.greenColor()
                self.Title2.fontColor = SKColor.greenColor()
                self.Start.fontColor = SKColor.greenColor()
                self.HighscoreLabel.fontColor = SKColor.greenColor()
                break
            case 3:
                self.Title1.fontColor = SKColor.blueColor()
                self.Title2.fontColor = SKColor.blueColor()
                self.Start.fontColor = SKColor.blueColor()
                self.HighscoreLabel.fontColor = SKColor.blueColor()
                break
            case 4:
                self.Title1.fontColor = SKColor.yellowColor()
                self.Title2.fontColor = SKColor.yellowColor()
                self.Start.fontColor = SKColor.yellowColor()
                self.HighscoreLabel.fontColor = SKColor.yellowColor()
                break
            case 5:
                self.Title1.fontColor = SKColor.orangeColor()
                self.Title2.fontColor = SKColor.orangeColor()
                self.Start.fontColor = SKColor.orangeColor()
                self.HighscoreLabel.fontColor = SKColor.orangeColor()
                break
            case 6:
                self.Title1.fontColor = SKColor.purpleColor()
                self.Title2.fontColor = SKColor.purpleColor()
                self.Start.fontColor = SKColor.purpleColor()
                self.HighscoreLabel.fontColor = SKColor.purpleColor()
                break

            default:
                self.Title1.fontColor = SKColor.whiteColor()
                self.Title2.fontColor = SKColor.whiteColor()
                self.Start.fontColor = SKColor.whiteColor()
                self.HighscoreLabel.fontColor = SKColor.whiteColor()
                self.colortime = 0
                break
            }
        }
        let wait = SKAction.waitForDuration(1)
        let sequence = SKAction.sequence([change, wait])
        return sequence
    }

}
