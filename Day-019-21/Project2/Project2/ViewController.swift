//
//  ViewController.swift
//  Project2
//
//  Created by Welby Jennings on 25/5/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]() //empty array
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1 // 1 point which is 2 px on retina and 3px on HD devices
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // see CALayer notes below
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        // UIColor has lightGray colour
        
        askQuestion()
        
    }
    // CALayer sits beneath all your UIViews (that's the parent of UIButton, UITableView)
    
    func askQuestion() {
        button1.setImage(UIImage(named: countries[0]),
                         for: .normal) // standard state of a button
        button2.setImage(UIImage(named: countries[1]),
                         for: .normal)
        button3.setImage(UIImage(named: countries[2]),
                         for: .normal)
    }

}

/*
 CALayer
 By default, the border of CALayer is black, but you can change that if you want by using the UIColor data type. I said that CALayer brings with it a little more complexity, and here's where it starts to be visible:
 
 CALayer sits at a lower technical level than UIButton, which means it doesn't understand what a UIColor is.
 UIButton knows what a UIColor is because they are both at the same technical level, but CALayer is below UIButton, so UIColor is a mystery.

 Don't despair, though: CALayer has its own way of setting colors called CGColor,
 - which comes from Apple's Core Graphics framework.
 - This, like CALayer, is at a lower level than UIButton, so the two can talk happily

 Even better, UIColor (which sits above CGColor) is able to convert to and from CGColor easily, which means you don't need to worry about the complexity
 */
