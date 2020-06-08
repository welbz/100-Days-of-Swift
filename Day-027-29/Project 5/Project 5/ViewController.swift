//
//  ViewController.swift
//  Project 5
//
//  Created by Welby Jennings on 7/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty { // isEmpty is faster than using count
            allWords = ["Silkworm"]
        }
        
        startGame() // call it at end of ViewDidLoad
    }
    
    func startGame() {
        title = allWords.randomElement() // sets VC title to a random word
        usedWords.removeAll(keepingCapacity: true) // removes all values from usedWords array
        tableView.reloadData() // Calls reload data method - asks to reload all rows from scratch - good for changing levels in game
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row] //read into usedWords array - user can see what they have found so far
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            // Closure
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased() // make lowercase
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) {
            if isOrignal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0) // inserts at top of table
                    
                    let indexPath = IndexPath(row: 0, section: 0) // inserts a row at 0 in section 0
                    tableView.insertRows(at: [indexPath], with: .automatic) // adding 1 cell is easier than reloading whole table
                    
                    return // if is fine, it exits before alerts show
                    
                } else { // isReal
                    errorTitle = "Word not recoginzed!"
                    errorMessage = "You can't just make them up"
                }
            } else { // isOriginal
                errorTitle = "Word already used!"
                errorMessage = "Be more original"
            }
        } else { // isPossible
            errorTitle = "Word not Possible!"
            errorMessage = "You can't spell that word from \(title!.lowercased())." // could use guard but title will exist
        }
        
        // if return did not get hit
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position) // removes first letter from tempWord and then loops over the string again
            } else {
                return false // if letter is not there it stops checking the word
            }
        }
        return true // if the loop finishes and has gone through all letters it returns true
    }
    
    func isOrignal(word: String) -> Bool {
        return !usedWords.contains(word) // NOT - if it contains word return false
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker() //UIKit spell checker - not good for Swift strings
        let range  = NSRange(location: 0, length: word.utf16.count)
        // Range to scan - start at 0 and scan full length of word - uses Object C string utf16.count cause of backwards compatability
        // UIKit / SpriteKit - Always use utf16.count for the character count
        // Swift or own code - Can use .count
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        // word is String to scan, range is how much of the range to scan, language is the dictionary to check the word against
        
        return misspelledRange.location == NSNotFound
        // tells us the word is spelled correctly
    }
    
}
