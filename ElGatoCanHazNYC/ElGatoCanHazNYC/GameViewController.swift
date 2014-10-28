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
    let MENU_SCENE_NAME = "menuScene"

    override func viewDidLoad() {
        super.viewDidLoad()

        let menuScene = MenuScene(size: self.view.bounds.size)
        menuScene.scaleMode = SKSceneScaleMode.AspectFill
    
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        menuScene.name = MENU_SCENE_NAME
    
        menuScene.completion = {
            let gameScene = GameScene(size: self.view.bounds.size)
            gameScene.scaleMode = SKSceneScaleMode.AspectFill
            let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 1)
            skView.presentScene(gameScene, transition: transition)
            gameScene.completion = {
                let gameOverScene = GameOverScene(size: self.view.bounds.size)
                gameOverScene.scaleMode = SKSceneScaleMode.AspectFill
                skView.presentScene(gameOverScene, transition: transition)
            }
        }
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        menuScene.scaleMode = .AspectFill
        
        skView.presentScene(menuScene)
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
