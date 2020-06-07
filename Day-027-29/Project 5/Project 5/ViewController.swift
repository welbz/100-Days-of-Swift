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
        
        
        if let startWordsURL = Bundle.main.url(forResource: "start",
           withExtension: "txt") {
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
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
        
    }
}

