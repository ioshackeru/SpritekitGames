//
//  GameViewController.swift
//  SpriteKitGame
//
//  Created by Tomer Buzaglo on 14/09/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let skview = view as? SKView else {return}
        
        let scene = GameScene(size: view.frame.size)
        scene.scaleMode = .aspectFill
        
        skview.showsNodeCount = true
        skview.showsFPS = true
        skview.ignoresSiblingOrder = true //more efficient, but we have to set z index
        //skview.showsPhysics = true
        //present the scene!
        skview.presentScene(scene)
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
