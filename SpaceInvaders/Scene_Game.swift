//
//  GameScene.swift
//  SpaceInvaders
//
//  Created by Marco De Lucchi on 07/05/16.
//  Copyright (c) 2016 Marco De Lucchi. All rights reserved.
//

import SpriteKit
import CoreMotion

struct CollisionCategories{
    static let Invader : UInt32 = 0x1 << 0
    static let Player: UInt32 = 0x1 << 1
    static let InvaderBullet: UInt32 = 0x1 << 2
    static let PlayerBullet: UInt32 = 0x1 << 3
    static let EdgeBody: UInt32 = 0x1 << 4
}

class Scene_Game: SKScene, SKPhysicsContactDelegate {
    let leftBounds = CGFloat(10)
    var rightBounds = CGFloat(0)
    var shift: CGFloat?
    var invadersWhoCanFire:[Invader] = []
    let player: Player = Player()
    let motionManager: CMMotionManager = CMMotionManager()
    var accelerationX: CGFloat = 0.0
    let score: Int = 0;
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity=CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        
        self.backgroundColor = SKColor.blackColor()
        
        rightBounds = self.size.width - 10
        shift = CGFloat(20)
        
        setupInvaders()
        setupPlayer()
        
        invokeInvaderFire()
        
        setupAccelerometer()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        player.fire(self)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        //Ordino body
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // Player colpito da proiettile
        if ((firstBody.categoryBitMask & CollisionCategories.Player != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.InvaderBullet != 0)) {
            print("Player and Invader Bullet Contact")
            player.die()
        }
        
        // Player colpito da invader
        if ((firstBody.categoryBitMask & CollisionCategories.Invader != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.Player != 0)) {
            print("Invader and Player Collision Contact")
            player.kill()
        }
        
        // Invader colpito da proiettile
        if ((firstBody.categoryBitMask & CollisionCategories.Invader != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.PlayerBullet != 0)){
            if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil) {
                return
            }
            
            let theInvader = firstBody.node as! Invader
            let newInvaderRow = theInvader.invaderRow - 1
            let newInvaderColumn = theInvader.invaderColumn
            if(newInvaderRow >= 1){
                self.enumerateChildNodesWithName("invader") { node, stop in
                    let invader = node as! Invader
                    if invader.invaderRow == newInvaderRow && invader.invaderColumn == newInvaderColumn{
                        self.invadersWhoCanFire.append(invader)
                        stop.memory = true
                    }
                }
            }
            let invaderIndex = findIndex(invadersWhoCanFire,valueToFind: firstBody.node as! Invader)
            if(invaderIndex != nil){
                invadersWhoCanFire.removeAtIndex(invaderIndex!)
            }
            theInvader.removeFromParent()
            secondBody.node?.removeFromParent()
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        moveInvaders()
    }
    
    //MARK: Setups
    func setupInvaders(){
        var invaderRow = 0;
        var invaderColumn = 0;
        let numberOfInvaders = LevelManager.invadersInRow
        for i in 1...LevelManager.rows {
        //for var i = 1; i <= LevelManager.rows; i += 1 {
            invaderRow = i
            for j in 1...numberOfInvaders {
            //for var j = 1; j <= numberOfInvaders; j++ {
                invaderColumn = j
                let tempInvader:Invader = Invader()
                let invaderHalfWidth:CGFloat = tempInvader.size.width/2
                let xPositionStart:CGFloat = size.width/2 - invaderHalfWidth - (CGFloat(LevelManager.level) * tempInvader.size.width) + CGFloat(10)
                tempInvader.position = CGPoint(x:xPositionStart + ((tempInvader.size.width+CGFloat(10))*(CGFloat(j-1))), y:CGFloat(self.size.height - CGFloat(i) * 46))
                tempInvader.invaderRow = invaderRow
                tempInvader.invaderColumn = invaderColumn
                addChild(tempInvader)
                if(i == LevelManager.rows){
                    invadersWhoCanFire.append(tempInvader)
                }
            }
        }
    }
    func setupPlayer(){
        player.position = CGPoint(x:CGRectGetMidX(self.frame), y:player.size.height/2 + 15)
        addChild(player)
    }
    
    func moveInvaders(){
        var changeDirection = false
        enumerateChildNodesWithName("invader") { node, stop in
            let invader = node as! SKSpriteNode
            let invaderHalfWidth = invader.size.width/2
            invader.position.x -= CGFloat(LevelManager.speed)
            if(invader.position.x > self.rightBounds - invaderHalfWidth || invader.position.x < self.leftBounds + invaderHalfWidth){
                changeDirection = true
            }
            
        }
        
        if(changeDirection == true){
            LevelManager.changeDirection()
            self.enumerateChildNodesWithName("invader") { node, stop in
                let invader = node as! SKSpriteNode
                invader.position.y -= self.shift!
            }
            changeDirection = false
        }
        
    }
    
    func invokeInvaderFire(){
        let fireBullet = SKAction.runBlock(){
            self.fireInvaderBullet()
        }
        let waitToFireInvaderBullet = SKAction.waitForDuration(1.5)
        let invaderFire = SKAction.sequence([fireBullet,waitToFireInvaderBullet])
        let repeatForeverAction = SKAction.repeatActionForever(invaderFire)
        runAction(repeatForeverAction)
    }
    
    func fireInvaderBullet(){
        if(invadersWhoCanFire.isEmpty){
            levelComplete()
        }else{
            let randomInvader = invadersWhoCanFire.randomElement()
            randomInvader.fire(self)
        }
    }
    
    func levelComplete(){
        LevelManager.nextLevel()
        let levelCompleteScene = Scene_LevelComplete(size: size)
        levelCompleteScene.scaleMode = scaleMode
        let transitionType = SKTransition.doorsOpenHorizontalWithDuration(1.0)
            view?.presentScene(levelCompleteScene,transition: transitionType)
    }
    
    func newGame(){
        
        let gameOverScene = Scene_StartGame(size: size)
        gameOverScene.scaleMode = scaleMode
        let transitionType = SKTransition.doorsOpenHorizontalWithDuration(1.0)
        view?.presentScene(gameOverScene,transition: transitionType)
    }
    
    func setupAccelerometer(){
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { accelerometerData, error in
            let acceleration = accelerometerData!.acceleration
            self.accelerationX = CGFloat(acceleration.x)
        })
    }
    
    override func didSimulatePhysics() {
        player.physicsBody?.velocity = CGVector(dx: accelerationX * 750, dy: 0)
    }
}

//MARK: Utilities
extension Array {
    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}