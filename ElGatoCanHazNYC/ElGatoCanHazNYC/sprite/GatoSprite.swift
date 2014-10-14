//
//  GatoSprite.swift
//  ElGatoCanHazNYC
//
//  Created by Jabari Bell on 10/14/14.
//  Copyright (c) 2014 23Bit. All rights reserved.
//

import SpriteKit

class GatoSprite : SKSpriteNode {
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        let gato = SKShapeNode.node()
        var gatoPath = UIBezierPath()
        gatoPath.moveToPoint(CGPoint(x: 0, y: 0))
        gatoPath.addLineToPoint(CGPoint(x: 0, y: 50))
        gatoPath.addLineToPoint(CGPoint(x: 50, y: 50))
        gato.path = gatoPath.CGPath
        gato.lineWidth = 10
        gato.strokeColor = UIColor.redColor()
        gato.antialiased = false
        self.addChild(gato)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
