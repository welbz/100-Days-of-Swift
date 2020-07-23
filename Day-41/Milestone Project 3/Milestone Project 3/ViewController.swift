//
//  ViewController.swift
//  Milestone Project 3
//
//  Created by Welby Jennings on 18/7/20.
//  Milestone Project 3
//  Recap Projects 7-9 (Days 33-40)
//  https://www.hackingwithswift.com/100/41



import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedLetters = [String]()
    var word = ""
    
    // didSets
    var wrongAnswer = 7 {
        didSet {
            title = "\(promptWord) Guesses \(wrongAnswer)/7"
        }
    }
    
    var promptWord = "" {
        didSet {
            title = "\(promptWord) Guesses \(wrongAnswer)/7"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nav Items
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        // Add words from file into allWords array
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["RHYTHM"]
        }
        
        print(allWords)
        startGame()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedLetters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usedLetters", for: indexPath)
        cell.textLabel?.text = usedLetters[indexPath.row]
        return cell
    }
    
    
    @objc func startGame() {
        word = ""
        promptWord = ""
        usedLetters.removeAll()
        
        if let GuessedWord = allWords.randomElement() {
            print(GuessedWord)
            word = GuessedWord
            
            for _ in word {
                promptWord += "?"
            }
        }
        
        // reload
        tableView.reloadData()
    }
    
    
    @objc func promptForAnswer () {
        let ac = UIAlertController(title: "Guess A Letter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer.uppercased())
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func submit(_ answer: String) {
        // Validations
        if answer == "" {
            let ac = UIAlertController (title: "Error", message: "Guess cannot be blank", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        } else if answer == " " {
            let ac = UIAlertController (title: "Error", message: "Guess cannot be blank", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        } else if answer.count >= 2 {
            let ac = UIAlertController (title: "Error", message: "Only 1 letter per guess", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        } else if usedLetters.contains(answer) {
            let ac = UIAlertController (title: "Error", message: "Letter already guessed", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try Again", style: .default))
            present(ac, animated: true)
            return
        }
        
        usedLetters.insert(answer, at: 0)
        
        if (!word.contains(answer)) {
            wrongAnswer -= 1
        }
        
        // Game over
        if wrongAnswer == 0 {
            let ac = UIAlertController(title: "Game Over", message: "You have no guesses remaining", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler:  {
                _ in self.startGame()
            }))
            
            present(ac,animated: true)
        }
        
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        checkGuess()
        
        return
    }
    
    // Check guess
    func checkGuess() {
        promptWord = ""
        
        for letter in word {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                promptWord += strLetter
            } else {
                promptWord  += "?"
            }
        }
        
        // Winner winner chicken dinner!
        if !promptWord.contains("?") {
            let ac = UIAlertController(title: "Winner", message: "You Win!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler:  { _ in
                self.startGame()
            }))
            
            present(ac, animated: true)
        }
    }
    
}
