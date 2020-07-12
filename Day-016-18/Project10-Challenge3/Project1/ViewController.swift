//
//  ViewController.swift
//  Project 10 - Challenge 3 (Copy of Project1)
//
//  Created by Welby Jennings on 23/5/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

/*
 
Removed - Changed from tableView to CollectionView

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        // forces large size title
        
        // MARK: - Project3 - Challenge 2
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        // MARK: - Project 9 - Challenge 1
        for item in items {
            if item.hasPrefix("nssl") {
                // this is the picture to load!
                pictures.append(item)
            }
        }
        print(pictures)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // dequeueReusableCell - table view cells are reused when they are go off the sceeen
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
            
            // add of let
            vc.pictureIndex = pictures.firstIndex(of: vc.selectedImage ?? "NA") ?? 0
            
            navigationController?.pushViewController(vc, animated: true)
            // Navigation controllers manage a stack of view controllers that can be pushed
        }
        
    }
    
    // MARK: - Project 3 - Challenge 2
    @objc func shareTapped() {
        
        guard let appURL =  URL(string: "https://apps.apple.com/us/app/scorecard/id1510711376")
        else {
            print("No App link found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

 
 */
