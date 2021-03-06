//
//  ViewController.swift
//  Project 9 - Challenge 1 (Copy of Project1)
//  Created by Welby Jennings on 23/5/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        // forces large size title
        
        // MARK: - Project 3 - Challenge 2
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        
        // MARK: - Project 9 - Challenge 1 - Adding GCD
        // Background thread
        print("Starting bg thread to append array")
        performSelector(inBackground: #selector(fetchAssets), with: nil)
        
        // performSelector makes tableView reloads data on the main thread
        print("Pushing back to main thread and reloading tableView")
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    
    // MARK: - Project 9 - Challenge 1 - Adding GCD
    @objc func fetchAssets() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is the picture to load!
                pictures.append(item)
            }
        }
        print(pictures)
      }
    
    
    
    // Table Views
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
            
            navigationController?.pushViewController(vc, animated: true) // Navigation controllers manage a stack of view controllers that can be pushed
        }
        /*
         3 things in that one line have the potential to fail
         if any of those things return nil, then the code inside the if let braces won’t run
         */
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
