//
//  GameScene.swift
//  ElGatoCanHazNYC
//
//  Created by Jabari Bell on 10/13/14.
//  Copyright (c) 2014 23Bit. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {

    //MARK: props
    var gatoTouch: UITouch?
    var lastUpdateTime: NSTimeInterval?
    var lastFireShotTime: NSTimeInterval = 0.0
    var lastEnemyGenerationTime: NSTimeInterval = 0.0
    var lastLaserShootTime: NSTimeInterval = 0.0
    
    var score: Int = 0
    
    let GATO_NAME = "elgato"
    let CHEESEBURGER_NAME = "cheeseburger"
    let UNICORN_NAME = "unicorn"
    let LAZER_NAME = "lazer"
    let ENEMY_KILL_SCORE = 3200
    
    let gato: SKSpriteNode = SKSpriteNode(imageNamed: "grumpyCat")
    
    let scoreLabel: SKLabelNode = SKLabelNode()
    
    
    //MARK: init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    //MARK: overrides
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.blackColor()
        gato.position = CGPoint(x: 100, y: 200)
        gato.size = CGSizeMake(60, 40)
        gato.name = GATO_NAME
        gato.userInteractionEnabled = false
        self.addChild(self.gato)
        self.addChild(scoreLabel)
        scoreLabel.position = CGPoint(x:self.size.width - 5, y:self.size.height - 40)
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
       self.gatoTouch = touches.anyObject() as? UITouch
    }
    
    override func update(currentTime: CFTimeInterval) {
        if let lut = self.lastUpdateTime {
            if lut == 0 {
                self.lastUpdateTime = currentTime
            }
            
            let timeDelta = currentTime - lut
            
            if let gt = self.gatoTouch {
                self.moveGatoTowardsPoint(gt.locationInNode(self), timeDelta: timeDelta)
                if currentTime - lastFireShotTime > 0.5 {
                    self.shootBurger()
                    lastFireShotTime = currentTime
                }
            }
            
            //should probably randomize this... as time goes on, more unicorns appear
            if currentTime - lastEnemyGenerationTime > 8 {
                generateEnemy()
                lastEnemyGenerationTime = currentTime
            }
            
            if currentTime - lastLaserShootTime > 2 {
                shootLaser()
                lastLaserShootTime = currentTime
            }
            
        } else {
            self.lastUpdateTime = 0
        }
        self.lastUpdateTime = currentTime;
        checkCollisions()
        updateScore()
    }
    
    func updateScore() {
        score += 10
        scoreLabel.text = String(score)
    }
    
    //MARK: movement stuff
    func moveGatoTowardsPoint(point: CGPoint, timeDelta: NSTimeInterval) {
        let gatoSpeed = 530.0
        
        if let gato = self.childNodeWithName(GATO_NAME) {
            let distanceLeft = sqrt(pow(gato.position.x, 2) + pow(gato.position.y - point.y, 2))
            
            if distanceLeft > 5 {
                let distanceToTravel = gatoSpeed * timeDelta
                let angle = atan2(point.y - gato.position.y, gato.position.x)
                let yOffset = CGFloat(distanceToTravel) * sin(angle)
//                println("yoffset \(yOffset)")
//                println("gato y \(gato.position.y)")
                gato.position = CGPoint(x: gato.position.x, y: floor(gato.position.y + yOffset))
            }
        } else {
            println("Couldn't find gato sprite.")
        }
    }
    
    func shootBurger() {
        if let gato = self.childNodeWithName(GATO_NAME) {
            let cheeseburger = SKSpriteNode(imageNamed: "cheezburger")
            cheeseburger.name = CHEESEBURGER_NAME
            cheeseburger.position = gato.position
            self.addChild(cheeseburger)
            
            let fly = SKAction.moveByX(cheeseburger.size.width + self.size.width, y: 0, duration: 0.5)
            
            let flyAndMove = SKAction.sequence([fly, removeAction()])
            cheeseburger.runAction(flyAndMove)
        }
    }
    
    func shootLaser() {
        //find a random enemy
        enumerateChildNodesWithName(UNICORN_NAME, usingBlock: {
            (unicorn: SKNode!, stop: UnsafeMutablePointer) -> Void in
            let randomInt = arc4random_uniform(100) + 1
            let mod = randomInt % 2
//            if mod == 0 {
                let laser = SKSpriteNode(imageNamed: "lazer")
                laser.name = self.LAZER_NAME
                laser.position = unicorn.position
                self.addChild(laser)
                
                let fly = SKAction.moveByX(-(laser.size.width + self.size.width), y: 0, duration: 1)
                let flyAndRemove = SKAction.sequence([fly, self.removeAction()])
                laser.runAction(flyAndRemove)
//            }
        })
    }
    
    func generateEnemy() {
        let enemy = SKSpriteNode(imageNamed: "unicorn")
        enemy.name = UNICORN_NAME
        enemy.size = CGSizeMake(60, 60)
        let yRange = (enemy.size.height, self.size.height - enemy.size.height)
        let enemyY = arc4random_uniform(UInt32(yRange.1 - yRange.0) + 1) + Int(yRange.0)
        enemy.position = CGPoint(x: self.size.width + enemy.size.width, y: CGFloat(enemyY))
        self.addChild(enemy)
        
        let durationRange = (8, 13)
        let duration = NSTimeInterval(arc4random_uniform(UInt32(durationRange.1 - durationRange.0) + 1) + durationRange.0)
        let fly = SKAction.moveByX(-(enemy.size.width + self.size.width), y: 0, duration: duration)
        let flyAndRemove = SKAction.sequence([fly, removeAction()])
        enemy.runAction(flyAndRemove)
    }
    
    func removeAction() -> SKAction {
        return SKAction.removeFromParent()
    }
    
    func checkCollisions() {
        let gato = childNodeWithName(GATO_NAME)
        enumerateChildNodesWithName(UNICORN_NAME, usingBlock: {
            (unicorn: SKNode!, stop: UnsafeMutablePointer) in
            if let gato = gato {
                if gato.intersectsNode(unicorn) {
                    gato.removeFromParent()
                    self.gameOver()
                }
                
                self.enumerateChildNodesWithName(self.LAZER_NAME, usingBlock: {
                    (laser: SKNode!, stop: UnsafeMutablePointer) in
                    if gato.intersectsNode(laser) {
                        gato.removeFromParent()
                        self.gameOver()
                    }
                })
            }
            
            self.enumerateChildNodesWithName(self.CHEESEBURGER_NAME, usingBlock: {
                (cheeseburger: SKNode!, stop: UnsafeMutablePointer) in
                if cheeseburger.intersectsNode(unicorn) {
                   unicorn.removeFromParent()
                   self.score += self.ENEMY_KILL_SCORE
                }
            })
            
        })
    }
    
    func gameOver() {
        
    }
}
