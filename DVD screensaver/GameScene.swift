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
  var dvdNode: SKSpriteNode!
  var containerNode: SKShapeNode!
  let logoWidth: CGFloat = 100
  var logoType = LogoType.random() {
    didSet {
      updateColor()
    }
  }
  let initialImpluse = CGVector(dx: 50, dy: 25)
  let contactBitMask: UInt32 = 1
  
  
  override func didMoveToView(view: SKView) {
    if !didSetup {
      setup()
      didSetup = true
    }
  }
  
  func updateBounds(){
    self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
    physicsBody?.friction = 0
    physicsBody?.contactTestBitMask = contactBitMask
    physicsBody?.categoryBitMask = contactBitMask
    dvdNode?.position = CGPoint(x: frame.midX, y: frame.midY)
  }
  
  func setup() {
    self.backgroundColor = UIColor.blackColor()
    self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    self.physicsWorld.contactDelegate = self
    updateBounds()

    dvdNode = SKSpriteNode(imageNamed: "logo")
    addChild(dvdNode)

    dvdNode.position = CGPoint(x: frame.midX, y: frame.midY)
    
    let ratio = dvdNode.size.height / dvdNode.size.width
    let logoHeight = ratio * logoWidth
    dvdNode.size = CGSize(width: logoWidth, height: logoHeight)

    dvdNode.physicsBody = SKPhysicsBody(rectangleOfSize: dvdNode.size)
    dvdNode.physicsBody?.friction = 0
    dvdNode.physicsBody?.restitution = 1
    dvdNode.physicsBody?.angularDamping = 0
    dvdNode.physicsBody?.linearDamping = 0
    dvdNode.physicsBody?.applyImpulse(initialImpluse)
    dvdNode.physicsBody?.contactTestBitMask = contactBitMask
    dvdNode.physicsBody?.categoryBitMask = contactBitMask

    

    
    containerNode = SKShapeNode(rect: CGRect(x: -logoWidth/2, y: -logoHeight/2, width: logoWidth, height: logoHeight))
    containerNode.strokeColor = UIColor.clearColor()
    dvdNode.addChild(containerNode)
    
    updateColor()
  }
  
  func updateColor() {
    if logoType == .Shape {
      dvdNode.colorBlendFactor = 0
      containerNode.fillColor = logoType.color()
    } else {
      containerNode.fillColor = UIColor.clearColor()
      dvdNode.color = logoType.color()
      dvdNode.colorBlendFactor = 1
    }
  }
  
  
  
  override func update(currentTime: CFTimeInterval) {
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    self.logoType = logoType == .Shape ? .Logo : .Shape
    
  }
}

extension GameScene: SKPhysicsContactDelegate {
  func didBeginContact(contact: SKPhysicsContact) {
    println("A")
    updateColor()
  }

}
