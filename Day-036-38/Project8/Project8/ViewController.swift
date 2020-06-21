//
//  ViewController.swift
//  Project8
//
//  Created by Welby Jennings on 14/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answerLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var LetterButtons = [UIButton]()
    
    // Buttons
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    // Scores
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)" // anytime this is changes it will be updated
        }
    }
    
    // Challenge 3
    var numberOfMatches = 0
    
    
    var level = 1
    
    
    override func loadView() {
        view = UIView() // parent of all view types
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical) // set priority
        view.addSubview(cluesLabel)
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = UIFont.systemFont(ofSize: 24)
        answerLabel.text = "ANSWERS"
        answerLabel.textAlignment = .right
        answerLabel.numberOfLines = 0
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical) // set priority
        view.addSubview(answerLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false // disables textField
        view.addSubview(currentAnswer)
        
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal) // state normal
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal) // state normal
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        
        // Container of buttons
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        // Chanellge 1 - Add Border
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
       
        // must have commas as its array
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo:
                view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo:
                view.layoutMarginsGuide.trailingAnchor),
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo:
                view.layoutMarginsGuide.leadingAnchor, constant: 100), // margin from left edge
            cluesLabel.widthAnchor.constraint(equalTo:
                view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            answerLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answerLabel.trailingAnchor.constraint(equalTo:
                view.layoutMarginsGuide.trailingAnchor, constant: -100), // margin from right edge
            answerLabel.widthAnchor.constraint(equalTo:
                view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            
            answerLabel.heightAnchor.constraint(equalTo:
                cluesLabel.heightAnchor), // makes the heights match
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5), // half width of screen
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20), // 20 below cluesLabel
            
            // Buttons
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor), // aligns to submit center
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // aligns to view center
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20), // 20 below submit
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            
        ])
        
        /*
         Every view in all our UIKit layouts has two important properties that tell UIKit how it can squash or stretch them in order to satisfy constraints:
         
         Content hugging priority determines how likely this view is to be made larger than its intrinsic content size. If this priority is high it means Auto Layout prefers not to stretch it; if it’s low, it will be more likely to be stretched.
         Content compression resistance priority determines how happy we are for this view to be made smaller than its intrinsic content size.
         Both of those values have a default: 250 for content hugging, and 750 for content compression resistance. Remember, higher priorities mean Auto Layout works harder to satisfy them, so you can see that views are usually fairly happy to be stretched, but prefer not to be squashed. Because all views have the same priorities for these two values, Auto Layout is forced to pick one to stretch – the score at the top.
         */
        
        
        // Creating a grid programmatically
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for column in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                LetterButtons.append(letterButton)
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLevel() // must run
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return } // safety check
        
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle) // add button title to our current answer text
        activatedButtons.append(sender) // add it to our activatedButtons array
        sender.isHidden = true // hides so cant tap it again
    }
    /*
     Does four things:

     It adds a safety check to read the title from the tapped button, or exit if it didn’t have one for some reason.
     Appends that button title to the player’s current answer.
     Appends the button to the activatedButtons array
     Hides the button that was tapped
     */
    
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            var splitAnswers = answerLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answerLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            
            score += 1
            numberOfMatches += 1
            
            
            // Challenge 3 - deduct points if incorrect guess - also need to track numberOfMatches to level up
            if numberOfMatches == 7 {
                let ac = UIAlertController(title: "Well Done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's Go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
         // Chanellge 2 - incorrect guess shows an alert telling them they are wrong
        } else {
            score -= 1
            
            let acError = UIAlertController(title: "Uh Oh!", message: "That is incorrect, try again", preferredStyle: .alert)
            acError.addAction(UIAlertAction(title: "OK", style: .default))
            present(acError, animated: true)
        }
        
    }
    /*
     earch through the solutions array for an item and, if it finds it, tells us its position. Remember, the return value of firstIndex(of:) is optional so that in situations where nothing is found you won't get a value back – we need to unwrap its return value carefully.

     If the user gets an answer correct, we're going to change the answers label so that rather than saying "7 LETTERS" it says "HAUNTED", so they know which ones they have solved already.
     
     firstIndex(of:)  will tell us which solution matched their word, then we can use that position to find the matching clue text. All we need to do is split the answer label text up by \n, replace the line at the solution position with the solution itself, then re-join the answers label back together
     */
    
    
    func levelUp(action: UIAlertAction) {
        level += 1
        
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        
        for button in LetterButtons {
            button.isHidden = false
        }
        
    }
    /*
    Add 1 to level.
    Remove all items from the solutions array.
    Call loadLevel() so that a new level file is loaded and shown.
    Make sure all our letter buttons are visible.
     
    clears out the existing solutions array before refilling it inside loadLevel()
    */
    
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        for btn in activatedButtons {
            btn.isHidden = false
        }
        
        activatedButtons.removeAll() // empties array
    }
    /*
     removes the text from the current answer text field
     unhides all the activated buttons
     then removes all the items from the activatedButtons array
     */
    
    
    
    func  loadLevel () {
        var clueString = ""
        var solutionsString = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)",
            withExtension: "txt") {
            if let levevlContents = try? String(contentsOf: levelFileURL) {
                var lines = levevlContents.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0] //left
                    let clue = parts[1] // right
                    
                    clueString += "\(index + 1). \(clue)\n" //1. clue text
                    
                    let solutionsWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionsString += "\(solutionsWord.count) letters\n"
                    solutions.append(solutionsWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                    
                }
                
            }
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answerLabel.text = solutionsString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        LetterButtons.shuffle()
        
        if LetterButtons.count == letterBits.count {
            for i in 0..<LetterButtons.count { // count through all letterButtons 0-19
                LetterButtons[i].setTitle(letterBits[i], for: .normal) //assigns that button's title to the matching bit in letterbits array
            }
        }
        
    }
    
}

