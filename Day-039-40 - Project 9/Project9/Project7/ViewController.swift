//
//  ViewController.swift
//  Project9 (from 7)
//
//  Created by Welby Jennings on 12/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

// it's never OK to do user interface work on the background thread.

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    let searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Petitions"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showFilters))
        
        // MARK: -  Challenge 1
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showCredits))
        
        // run fetchJSON in background
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
    }
    
    
    // moved all code to function
    @objc func fetchJSON() {
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        // blocking call which freezes main thread used for UI - should move to a background thread
        
        
        // closure
        if let url = URL(string: urlString) {
            
            if let data = try? Data(contentsOf: url) { // returns contents of url
                
                parse(json: data) // needs self?
                return // if parse worked, return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    
    // MARK: - Challenge 1
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
            print("submitting")
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    // TODO: check all petition objects title and body for search word -
    func submit(_ searchText: String) {
        let searchItem = searchText.lowercased()
        print(searchItem)
        print(filteredPetitions.count)
        
         
        // FIXME: - This code to fix - search for word in paragraph -
        for item in petitions {
            if item.title.contains("\(searchItem)") || item.body.contains(searchItem) {
                filteredPetitions.insert(item, at: 0)
            }
            
            print(filteredPetitions.count)
            //print(filteredPetitions)
            
            /*
             let searchedPetitions = petitions.filter { $0.body == searchItem }
             // $0.title == searchItem || $0.body == searchItem
             
             print(searchedPetitions.count)
             
             // insert the results into filteredPetitions array
             filteredPetitions.insert(contentsOf: searchedPetitions, at: 0)
             print(filteredPetitions.count)
             
             return
             */
        }
        tableView.reloadData()
    }

    
    // showError will always be on main thread due to performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    @objc func showError() {
        
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed try again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    
    
    func parse(json: Data) { // new parse method
        let decoder = JSONDecoder() // decoder
        
        // asks decoder to convert its data to single a petitions object - find type and make instance of it from json
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            
            // performSelector makes tableView reloads data on the main thread
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
            // Error if it fails to decode json
        }
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

