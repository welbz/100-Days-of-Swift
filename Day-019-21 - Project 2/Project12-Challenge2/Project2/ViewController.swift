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
    var correctAnswer = 0
    var totalQuestions = 0
    var highestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Testing purposes
        // resetDefaults()
        print("Current Highest Score: \(highestScore)")
        
        // MARK: Project12 - Challenge 2
        // Read from UserDefaults
        let defaults = UserDefaults.standard
        let savedScore = defaults.integer(forKey: "highest")
        highestScore = savedScore
        print("Current Highest Score: \(highestScore)")
        
        
        
        // MARK: Project3 - Challenge 3
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
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
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle() // auto randomise array
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]),
                         for: .normal) // standard state of a button
        button2.setImage(UIImage(named: countries[1]),
                         for: .normal)
        button3.setImage(UIImage(named: countries[2]),
                         for: .normal)
        
        title = countries[correctAnswer].uppercased() + " - Your Score: " + String(score)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        totalQuestions += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        
        
        if totalQuestions < 5 {
            let ac = UIAlertController(title: title, message: "Your current score is \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Continue",
                                       style: .default, handler: askQuestion)) // dont use askQuestion()
            // Alert options are .default, .cancel, and .destructive
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "Your final score is \(score) / \(totalQuestions)", preferredStyle: .alert)
            
            // MARK: Project12 - Challenge 2
            if score > highestScore {
                print("New Highest Score: \(highestScore)")
                
                // Write to UserDefaults
                let defaults = UserDefaults.standard
                defaults.set(score, forKey: "highest")
                let high = UIAlertController(title: title, message: "New highest Score! \(score) / \(totalQuestions)", preferredStyle: .alert)
                
                high.addAction(UIAlertAction(title: "Restart",
                                             style: .default, handler: askQuestion)) // dont use askQuestion()
                present(high, animated: true)
                
                totalQuestions = 0
                score = 0
            }
            
            ac.addAction(UIAlertAction(title: "Restart",
                                       style: .default, handler: askQuestion)) // dont use askQuestion()
            present(ac, animated: true)
            
            totalQuestions = 0
            score = 0
        }
        
    }
    
    // MARK: Project 3 - Challenge 3 - Show score when nav button tapped
    @objc func shareTapped() {
        let ac = UIAlertController(title: "Your Score", message: "\(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue",
                                   style: .default))
        present(ac, animated: true)
    }
    
    func resetDefaults() {
        UserDefaults.standard.removePersistentDomain(forName: "highest")
        UserDefaults.standard.synchronize()
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
