//
//  ViewController.swift
//  Milestone Project 2
//
//  Created by Welby Jennings on 11/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeItems))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
    }
    
    // Table View - number rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    // Table View
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row] //read into usedWords array - user can see what they have found so far
        return cell
    }
    
    
    @objc func removeItems() {
        shoppingList.removeAll(keepingCapacity: true)
        print("removes all values from array")
        
        tableView.reloadData()
        print("reload")
    }

    @objc func addItem() {
        let ac = UIAlertController(title: "Enter Item Name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Save", style: .default) {
            // Closure
            [weak self, weak ac] action in
            guard let itemInputText = ac?.textFields?[0].text else { return }
            self?.submit(itemInputText)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ itemInputText: String) {
        let newItem = itemInputText.capitalized
        
        shoppingList.insert(newItem, at: 0)
        print("inserting \(newItem) into array")
        
        let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
    }
    

}

