//
//  GameViewController.swift
//  ElGatoCanHazNYC
//
//  Created by Jabari Bell on 10/13/14.
//  Copyright (c) 2014 23Bit. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    let GAME_SCENE_NAME = "gameScene"

    override func viewDidLoad() {
        super.viewDidLoad()

            let scene = GameScene(size: self.view.bounds.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
        
            let skView = self.view as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            scene.name = GAME_SCENE_NAME
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
