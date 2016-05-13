//
//  Player.swift
//  SpaceInvaders
//
//  Created by Marco De Lucchi on 08/05/16.
//  Copyright © 2016 Marco De Lucchi. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode {
    private var canFire = true
    private var invincible = false
    private var lives:Int = 3 { //Pattern: Observer
        didSet {
            guard lives < 1 else {
                print("vita -- ", lives)
                respawn()
                return
            }
            kill()
        }
    }
    
    init () {
        let texture = SKTexture(imageNamed: "player")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.physicsBody = SKPhysicsBody(texture: self.texture!,size:self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = CollisionCategories.Player
        self.physicsBody?.contactTestBitMask = CollisionCategories.InvaderBullet | CollisionCategories.Invader
        self.physicsBody?.collisionBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.allowsRotation=false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fire(scene: SKScene){
        if canFire {
            canFire = false
            let bullet = PlayerBullet(imageName: "bullet", bulletSound: "shootingSound.mp3")
            bullet.position.x = self.position.x
            bullet.position.y = self.position.y + self.size.height/2
            scene.addChild(bullet)
            let moveBulletAction = SKAction.moveTo(CGPoint(x:self.position.x,y:scene.size.height + bullet.size.height), duration: 1.0)
            let removeBulletAction = SKAction.removeFromParent()
            bullet.runAction(SKAction.sequence([moveBulletAction,removeBulletAction]))
            let waitToEnableFire = SKAction.waitForDuration(0.5)
            runAction(waitToEnableFire,completion:{
                self.canFire = true
            })
        }
    }
    
    func respawn(){
        invincible = true
        let fadeOutAction = SKAction.fadeOutWithDuration(0.4)
        let fadeInAction = SKAction.fadeInWithDuration(0.4)
        let fadeOutIn = SKAction.sequence([fadeOutAction,fadeInAction])
        let fadeOutInAction = SKAction.repeatAction(fadeOutIn, count: 5)
        let setInvicibleFalse = SKAction.runBlock(){
            self.invincible = false
        }
        runAction(SKAction.sequence([fadeOutInAction,setInvicibleFalse]))
        
    }
    
    func die (){
        if(!invincible){
            lives -= 1
            //TODO: Togli i cuori
        }
    }
    
    func kill(){
        LevelManager.newGame()
        let gameOverScene = Scene_StartGame(size: self.scene!.size)
        gameOverScene.scaleMode = self.scene!.scaleMode
        let transitionType = SKTransition.doorsOpenHorizontalWithDuration(1.0)
        self.scene!.view!.presentScene(gameOverScene,transition: transitionType)
    }
    
}
