//
//  SplashVC.swift
//  dvd-saver
//
//  Created by Bergman, Yon on 8/5/15.
//  Copyright (c) 2015 yonbergman. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
  
  @IBOutlet weak var line: UIView!
  @IBOutlet weak var circle: Circle!

  override func viewDidAppear(animated: Bool) {
    let view = self.view
    self.line.frame = CGRect(x: 0, y: view.bounds.midY, width: 0, height: 0)
    self.circle.frame = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
    UIView.animateWithDuration(0.4, animations: { () -> Void in
      self.line.frame = CGRect(x: 0, y: view.bounds.midY, width: view.bounds.width, height: 3)
    })
    UIView.animateWithDuration(0.4, delay: 0.6, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
      self.line.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
      }, completion: nil)
    
    let size = max(view.bounds.height, view.bounds.width) * 2
    UIView.animateWithDuration(1, animations: { () -> Void in
      self.circle.frame = CGRect(x: view.bounds.midX - size/2 , y: view.bounds.midY - size/2, width: size, height: size)
    })
    
    UIView.animateWithDuration(0.2, delay: 0.9, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
     self.circle.alpha = 0
    self.line.alpha = 0
      }, completion: { done in
        self.performSegueWithIdentifier("next", sender: nil)
    })
  }
}
class Circle: UIView {
  
  override func drawRect(rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    let space = CGColorSpaceCreateDeviceRGB();

    let gradient = CGGradientCreateWithColors(space, [UIColor.whiteColor().CGColor, UIColor.whiteColor().colorWithAlphaComponent(0).CGColor], nil)
    CGContextDrawRadialGradient(context, gradient, CGPoint(x: rect.midX, y: rect.midY), 0, CGPoint(x: rect.midX, y: rect.midY), rect.width / 2, CGGradientDrawingOptions.allZeros)
    context
  }
  
}