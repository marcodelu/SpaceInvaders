//
//  GameViewController.swift
//  SpaceInvaders
//
//  Created by Marco De Lucchi on 07/05/16.
//  Copyright (c) 2016 Marco De Lucchi. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    //When app loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = Scene_StartGame(size: view.bounds.size)
        let skView = view as! SKView
        /*Debug START
        skView.showsFPS = true
        skView.showsNodeCount = true
        Debug END*/
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}
