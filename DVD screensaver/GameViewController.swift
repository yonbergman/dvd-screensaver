//
//  GameViewController.swift
//  DVD screensaver
//
//  Created by Bergman, Yon on 8/3/15.
//  Copyright (c) 2015 yonbergman. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  var scene: GameScene!
  
  var skView: SKView { return view as! SKView }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    skView.showsFPS = true
//    skView.showsNodeCount = true
//    skView.showsPhysics = true
    skView.ignoresSiblingOrder = true
  }
  
  override func viewWillLayoutSubviews() {
    super.viewDidLayoutSubviews()
    println("didLayout")
    if scene == nil {
      scene = GameScene(size: skView.bounds.size)
      scene.scaleMode = .AspectFill
      skView.presentScene(scene)
    } else {
      scene.size = skView.bounds.size
      scene.updateBounds()
    }
    //    skView.
    //    self.scene.scene?.size = self.scene.frame.size
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
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}
