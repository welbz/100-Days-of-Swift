//
//  TableViewController.swift
//  Project 4
//
//  Created by Welby Jennings on 4/7/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var websites = ["apple.com", "zakemedia.com.au", "welbyjennings.com"]
    var safeWebsites = ["apple", "zakemedia"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Websites"
        navigationController?.navigationBar.prefersLargeTitles = true
     
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "webCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier:
            "Detail") as? DetailViewController {
            vc.selectedItem = websites[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
            // Navigation controllers manage a stack of view controllers that can be pushed
        }
    }
   

}
