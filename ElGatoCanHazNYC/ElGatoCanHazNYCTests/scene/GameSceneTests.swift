//
//  GameSceneTests.swift
//  ElGatoCanHazNYC
//
//  Created by Jabari Bell on 10/15/14.
//  Copyright (c) 2014 23Bit. All rights reserved.
//

import SpriteKit
import Nimble
import Quick

class Timer {
    var timer = NSTimer()
    var handler: (Int) -> ()
    
    let duration: Int
    var elapsedTime: Int = 0
    
    init(duration: Int, handler: (Int) -> ()) {
        self.duration = duration
        self.handler = handler
    }
    
    func start() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
            target: self,
            selector: Selector("tick"),
            userInfo: nil,
            repeats: true)
    }
    
    func stop() {
        timer.invalidate()
    }
    
    @objc func tick() {
        self.elapsedTime++
        
        self.handler(elapsedTime)
        
        if self.elapsedTime == self.duration {
            self.stop()
        }
    }
    
    deinit {
        self.timer.invalidate()
    }
}

class GameSceneTests: QuickSpec {
    
    //MARK: properties
    
    override func spec() {
        let deviceBounds = UIScreen.mainScreen().bounds
        var view :SKView?
        var scene :GameScene?
        //MARK: before and after
        
//        beforeSuite {
//            
//        }
//        
//        afterSuite {
//            
//        }
        beforeEach {
            view = SKView(frame: deviceBounds)
            scene = GameScene(size: deviceBounds.size)
            scene?.didMoveToView(view!)
        }
        
        afterEach {
           view = nil
           scene = nil
        }
        
        //MARK: specs
        describe("the game scene") {
           
            //MARK: gato specs
            describe("el gato") {
                
                context("when the screen is touched") {
                    
                    it("should move vertically towards the touch") {
                        
                        let tapPoint = CGPoint(x: scene!.gato.position.x, y: scene!.gato.position.y + 100)
                        
                        let timer = Timer(duration: 100, handler: {
                            (time: Int) -> () in
                            scene!.moveGatoTowardsPoint(tapPoint, timeDelta: 0.16)
                        })
                        
                        timer.start()
                        
                        expect(scene!.gato.position.y).toEventually(beGreaterThanOrEqualTo(tapPoint.y - 2), timeout: 100, pollInterval: 1)
                    }
                    
                    it("should not move horizontally when the screen is touched") {
                        
                        let gatoStartX = scene!.gato.position.x
                        let tapPoint = CGPoint(x: gatoStartX + 200, y: scene!.gato.position.y + 100)
                        expect(scene!.gato.position.x).to(equal(gatoStartX))
                    }
                    
                    it("should fire cheeseburgers") {
                        
                    }
                    
                }
            }
        }
    }
}
