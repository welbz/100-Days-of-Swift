//
//  ViewController.swift
//  Project15
//
//  Created by Welby Jennings on 29/7/20.
//

import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView!
    var currentAnimation = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create new imageView programatically - center on screen - add it to our parent view
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }
    
    @IBAction func tapped(_ sender: UIButton) {
        sender.isHidden = true
        
        //UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            
            switch self.currentAnimation {
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2) // twice normal size
                break
            case 1:
                self.imageView.transform = .identity // clears out previous animations
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256) // move to left and up
            case 3:
                self.imageView.transform = .identity
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: .pi) // 180 degrees
            case 5:
                self.imageView.transform = .identity
            case 6:
                self.imageView.alpha = 0.1 // can change alpha and background
                self.imageView.backgroundColor = .green
            case 7:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = .clear
            default:
                break
            } // animations closure
        }) { finished in
            sender.isHidden = false // show sender button again
        } // finished closure
        // no need for weak self
        
        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
    
}

// See Notes for info on Rotation
