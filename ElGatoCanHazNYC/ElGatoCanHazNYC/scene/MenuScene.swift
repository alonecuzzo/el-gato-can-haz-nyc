//
//  MenuScene.swift
//  ElGatoCanHazNYC
//
//  Created by Jabari Bell on 10/28/14.
//  Copyright (c) 2014 23Bit. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {

    var completion : dispatch_block_t = {}
    
    //MARK: init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.completion()
    }
    
}
