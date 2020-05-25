//
//  ViewController.swift
//  Project1
//
//  Created by Welby Jennings on 23/5/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true // forces large size title
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
    
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
                pictures.append(item)
            }
        }
        print(pictures)
    }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // table view cells are reused when they are go off the sceeen
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures.sorted()[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier:
            "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.pictureTotal = pictures.count
            //vc.pictureIndex = pictures.IndexPath.item
            navigationController?.pushViewController(vc, animated: true) // Navigation controllers manage a stack of view controllers that can be pushed
        }
        /*
         3 things in that one line have the potential to fail
         if any of those things return nil, then the code inside the if let braces won’t run
         */
    }
}
