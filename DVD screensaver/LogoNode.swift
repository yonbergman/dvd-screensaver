//
//  LogoNode.swift
//  DVD screensaver
//
//  Created by Bergman, Yon on 8/5/15.
//  Copyright (c) 2015 yonbergman. All rights reserved.
//

import Foundation
import SpriteKit

enum LogoType {
  static let imgName = "logo"
  
  case Shape, Logo
  
  static func random() -> LogoType {
    return [LogoType.Shape, LogoType.Logo].sample()
  }
  
  var imageNamed: String { return LogoType.imgName }
  
  func color() -> SKColor {
    return [
      SKColor.greenColor(),
      SKColor.redColor(),
      SKColor.yellowColor(),
      SKColor.orangeColor()
      ].sample()
  }
  
  static let Default = LogoType.Logo
}



class LogoNode: SKNode {
  
  var type: LogoType = LogoType.random()
  
  let imgNode: SKSpriteNode
  let containerNode: SKShapeNode

  let logoWidth: CGFloat = 100
  
  override init() {

    imgNode = SKSpriteNode(imageNamed: type.imageNamed)


    
//    dvdNode.position = CGPoint(x: frame.midX, y: frame.midY)
    
    let imgRatio = imgNode.size.height / imgNode.size.width
    let logoHeight = imgRatio * logoWidth
    imgNode.size = CGSize(width: logoWidth, height: logoHeight)
    
    imgNode.physicsBody = SKPhysicsBody(rectangleOfSize: imgNode.size)
    imgNode.physicsBody?.friction = 0
    imgNode.physicsBody?.restitution = 1
    imgNode.physicsBody?.angularDamping = 0
    imgNode.physicsBody?.linearDamping = 0
//    imgNode.physicsBody?.applyImpulse(initialImpluse)
    imgNode.physicsBody?.contactTestBitMask = kContactBitMask
    imgNode.physicsBody?.categoryBitMask = kContactBitMask
    
    
    containerNode = SKShapeNode(rect: CGRect(x: -logoWidth/2, y: -logoHeight/2,
                                             width: logoWidth, height: logoHeight))
    containerNode.strokeColor = UIColor.clearColor()
    
    
    super.init()
    addChild(imgNode)
    imgNode.addChild(containerNode)
    updateColor()
  }
  

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func updateColor() {
    if type == .Shape {
      imgNode.colorBlendFactor = 0
      containerNode.fillColor = type.color()
    } else {
      containerNode.fillColor = UIColor.clearColor()
      imgNode.color = type.color()
      imgNode.colorBlendFactor = 1
    }
  }
  
}