//
//  ViewController.swift
//  TwitterAppLaunchTypeAnimation
//
//  Created by Apple on 12/03/18.
//  Copyright © 2018 Vignesh. All rights reserved.
//

import UIKit

class TwitterLaunchAnimationVC: UIViewController, CAAnimationDelegate{
    
    // Outlets:
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    
    // Variables:
    
    var mask : CALayer!
    var animation: CABasicAnimation!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLaunch(image: UIImage(named: "logo")!, bgColor: #colorLiteral(red: 0, green: 0.6705882353, blue: 0.862745098, alpha: 1))
    }
    
    func animateLaunch(image: UIImage, bgColor: UIColor) {
        self.view.backgroundColor = bgColor
        
        // Create & apply mask
        mask = CALayer()
        mask.contents = image.cgImage
        mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mask.position = CGPoint(x: mainView.frame.width / 2.0, y: mainView.frame.height / 2.0)
        mainView.layer.mask = mask
        
        
    }
    
    func animateDecreaseInSize() {
        
        // Initially decrease the size of the mask
        let decreaseSize = CABasicAnimation(keyPath: "bounds")
        decreaseSize.delegate = self
        decreaseSize.duration = 0.75
        decreaseSize.fromValue = NSValue(cgRect: mask.bounds)
        decreaseSize.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        // Ensure that animation is not removed on completion
        decreaseSize.fillMode = kCAFillModeForwards
        decreaseSize.isRemovedOnCompletion = false
        
        // Add animation to the mask
        mask.add(decreaseSize, forKey: "bounds")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animateIncreaseInSize()
    }
    
    func animateIncreaseInSize() {
        
         animation = CABasicAnimation(keyPath: "bounds")
        animation.duration = 0.75
        animation.fromValue = NSValue(cgRect: mask.bounds)
        animation.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 8000, height: 8000))
        
        // Ensure that animation is not removed on completion
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        // Add animation to the mask
        mask.add(animation, forKey: "bounds")
        
        // Fade out overlay
        UIView.animate(withDuration: 0.75, animations: {
            self.overlayView.alpha = 0
        }, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateDecreaseInSize()
        
    }
    

}

