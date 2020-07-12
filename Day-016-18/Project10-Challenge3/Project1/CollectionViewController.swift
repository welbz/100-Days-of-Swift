//
//  CollectionViewController.swift
//  Project1
//
//  Created by Welby Jennings on 12/7/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

// MARK: - Project 10 - Challenge 3
class CollectionViewController: UICollectionViewController {
    var pictures = [String]()
    
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
                // this is the picture to load!
                pictures.append(item)
            }
        }
        print(pictures)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pictures.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            
            fatalError("Unable to dequeue a PictureCell")
        }
        
        let picture = pictures[indexPath.item]
        
        cell.name.text = picture
        
        cell.imageView.image = UIImage(named: picture)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as?
            DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.pictureTotal = pictures.count
            
            // add if let
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
