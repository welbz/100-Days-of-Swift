//
//  ViewController.swift
//  Project7
//
//  Created by Welby Jennings on 12/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]() // Challenge 2
    let searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Petitions"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showFilters))
        
        // Challenge 1
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showCredits))
        
        
        // Downloads the data from the Whitehouse petitions server, converts it to a Swift Data object, then tries to convert it to an array of Petition instances
        
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) { // returns contents of url
                parse(json: data)
                return // if parse worked, return
            }
        }
        showError() // failed so show error
    }
    
    // Challenge 1
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "This data is from We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showFilters() {
        let ac = UIAlertController(title: "Search for a word", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Search", style: .default) {
            // Closure
            [weak self, weak ac] action in
            guard let searchText = ac?.textFields?[0].text else { return }
            self?.submit(searchText)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    // Challenge 2
    func submit(_ searchText: String) {
        
        let searchItem: String = searchText.lowercased()
        
        print("Submitting")
        print("Searched Word: \(searchItem)")
        print("Total Petitions: \(petitions.count)")
        print("Filtered Petitions: \(filteredPetitions.count)")
        
        for item in petitions {
            let itemTitle: String = item.title
            let itemBody: String = item.body
            
            if itemTitle.contains("\(searchItem)") || itemBody.contains("\(searchItem)") {
                filteredPetitions.insert(item, at: 0)
                print("insering petitions containing \"\(searchItem)\" into filteredPetitions array")
            }
        }
        
        print("Petitions now in filteredPetitions: \(filteredPetitions.count)")
        
        tableView.reloadData()
    }
    
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) { // new parse method
        let decoder = JSONDecoder() // decoder
        
        // asks decoder to convert its data to single a petitions object - find type and make instance of it from json
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
        print("Total petitions loaded: \(petitions.count)")
    }
    
    
    
    // Table View Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredPetitions.isEmpty {
            return petitions.count
        } else {
            return filteredPetitions.count
        }
    }
    
    // Table View Cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

