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
  
  case Square, Logo, Oval
  
  static func random() -> LogoType {
    return [LogoType.Square, LogoType.Logo].sample()
  }
  
  var imageNamed: String { return LogoType.imgName }
  
  func randomColor() -> SKColor {
    return [
      SKColor.greenColor(),
      SKColor.redColor(),
      SKColor.yellowColor(),
      SKColor.orangeColor()
      ].sample()
  }
  
  func backgroundColor() -> SKColor {
    switch self {
      case .Oval, .Square: return randomColor()
      default: return SKColor.clearColor()
    }
  }
  
  func logoColor() -> SKColor {
    switch self {
      case .Oval, .Square: return SKColor.whiteColor()
      default: return randomColor()
    }
  }
  
  func next() -> LogoType {
    switch self {
    case .Square: return .Logo
    case .Logo: return .Oval
    case .Oval: return .Square
    }
  }
  
  var scale: CGFloat {
    switch self {
    case .Square: return 0.8
    case .Logo: return 1
    case .Oval: return 0.7
    }
  }
  
  var colorBlendFactor: CGFloat {
    switch self {
    case .Square, .Oval: return 0
    case .Logo: return 1
    }
  }
  
  func pathForFrame(frame: CGRect) -> CGPath {
    switch self {
      case .Oval: return UIBezierPath(ovalInRect: frame).CGPath
      case .Square: return UIBezierPath(rect: frame).CGPath
      default: return UIBezierPath(rect: frame).CGPath
    }
  }
  
  static let Default = LogoType.Logo
}



class LogoNode: SKNode {
  
  var type: LogoType = LogoType.random() {
    didSet {
      updateColor()
    }
  }
  
  let imgNode: SKSpriteNode
  let containerNode: SKShapeNode

  let logoWidth: CGFloat = 100
  
  override init() {

    imgNode = SKSpriteNode(imageNamed: type.imageNamed)

    let imgRatio = imgNode.size.height / imgNode.size.width
    let logoHeight = imgRatio * logoWidth
    imgNode.size = CGSize(width: logoWidth, height: logoHeight)
    
    
    
    
    containerNode = SKShapeNode(rect: CGRect(x: -logoWidth/2, y: -logoHeight/2,
                                             width: logoWidth, height: logoHeight))
    containerNode.strokeColor = UIColor.clearColor()
    
    super.init()
    addChild(imgNode)
    addChild(containerNode)
    addPhysics()
    updateColor()
  }
  
  private func addPhysics() {
    physicsBody = SKPhysicsBody(rectangleOfSize: imgNode.size)
    physicsBody?.friction = 0
    physicsBody?.restitution = 1
    physicsBody?.angularDamping = 0
    physicsBody?.linearDamping = 0
    physicsBody?.contactTestBitMask = kContactBitMask
    physicsBody?.categoryBitMask = kContactBitMask
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func updateColor() {
    imgNode.colorBlendFactor = type.colorBlendFactor
    imgNode.color = type.logoColor()
    imgNode.xScale = type.scale
    imgNode.yScale = type.scale
    containerNode.fillColor = type.backgroundColor()
    containerNode.path = type.pathForFrame(containerNode.frame)
  }
  
  func applyImpulse(vector: CGVector) {
    physicsBody?.applyImpulse(vector)
  }
  
  func toggleType() {
    type = type.next()
  }
  
}