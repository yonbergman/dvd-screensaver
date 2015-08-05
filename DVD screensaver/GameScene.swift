//
//  GameScene.swift
//  DVD screensaver
//
//  Created by Bergman, Yon on 8/3/15.
//  Copyright (c) 2015 yonbergman. All rights reserved.
//

import SpriteKit

extension Array {
  func sample() -> Element {
    let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
    return self[randomIndex]
  }
}

class GameScene: SKScene {
  
  
  var didSetup = false
  var logoNode: LogoNode!
  let initialImpluse = CGVector(dx: 50, dy: 25)
  
  override func didMoveToView(view: SKView) {
    if !didSetup {
      setup()
      didSetup = true
    }
  }
  
  func updateBounds(){
    self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
    physicsBody?.friction = 0
    physicsBody?.contactTestBitMask = kContactBitMask
    physicsBody?.categoryBitMask = kContactBitMask
    centerLogo()
  }
  
  func centerLogo() {
    logoNode?.position = CGPoint(x: frame.midX, y: frame.midY)
  }
  
  func setup() {
    self.backgroundColor = UIColor.blackColor()
    self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    self.physicsWorld.contactDelegate = self
    updateBounds()

    logoNode = LogoNode()
    addChild(logoNode)
    centerLogo()
    logoNode.applyImpulse(initialImpluse)
  }

  override func update(currentTime: CFTimeInterval) {
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    logoNode.toggleType()
  }
}

extension GameScene: SKPhysicsContactDelegate {
  func didBeginContact(contact: SKPhysicsContact) {
    logoNode.updateColor()
  }

}
