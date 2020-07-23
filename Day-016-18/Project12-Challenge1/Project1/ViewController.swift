//
//  ViewController.swift
//  Project1 (Copy)
//  Project 12 - Challenge 1 - https://www.hackingwithswift.com/read/12/5/wrap-up
//  Created by Welby Jennings on 23/5/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    // MARK: - Project 12 - Challenge 1
    var pictureViews = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // MARK: - Project3 - Challenge 2
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        // MARK: - Project 9 - Challenge 1
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                
                // MARK: - Project 12 - Challenge 1
                let defaults = UserDefaults.standard
                let count = defaults.integer(forKey: item)
                pictureViews.append(count)
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
        // Display count here in future
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.pictureTotal = pictures.count
            vc.pictureIndex = pictures.firstIndex(of: vc.selectedImage ?? "NA") ?? 0
            
            // MARK: - Project 12 - Challenge 1
            var pictureCount = pictureViews[indexPath.row]
            pictureCount += 1
            let defaults = UserDefaults.standard
            defaults.set(pictureCount, forKey: pictures[indexPath.row])
            
            print(pictureCount)
            
            navigationController?.pushViewController(vc, animated: true)
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
