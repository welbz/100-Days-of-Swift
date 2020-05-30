//
//  ViewController.swift
//  Milestone Project 1
//
//  Created by Welby Jennings on 30/5/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var flagImages = [String]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "World Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                flagImages.append(String(item.dropLast(4))) // removes last 4 .png
            }
        }
        print(flagImages)
    }
    
    // table view number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagImages.count
    }
    
    // table view cells are reused when they are go off the sceeen
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = flagImages[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(withIdentifier:
        "Detail") as? DetailViewController {
        vc.selectedImage = flagImages[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true) // Navigation controllers manage a stack of view controllers that can be pushed
        }
    }
    
}

