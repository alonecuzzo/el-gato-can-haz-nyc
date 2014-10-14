//
//  GameScene.swift
//  ElGatoCanHazNYC
//
//  Created by Jabari Bell on 10/13/14.
//  Copyright (c) 2014 23Bit. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        let gato = GatoSprite(texture: nil, color: UIColor.redColor(), size: CGSize(width: 20, height: 20))
        gato.position = CGPoint(x: 100, y: 200)
        gato.size = CGSizeMake(100, 100)
        self.addChild(gato)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
