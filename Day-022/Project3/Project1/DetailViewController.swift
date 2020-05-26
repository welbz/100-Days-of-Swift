//
//  DetailViewController.swift
//  Project1
//
//  Created by Welby Jennings on 24/5/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var pictureTotal = 0
    var pictureIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(pictureIndex + 1) of \(pictureTotal)"
        navigationItem.largeTitleDisplayMode = .never  // forces normal size title
        
        // Bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        // .action is the share (up arrow box icon)
        // gives functionality to share by iMessage, email, Twitter, Facebook, saving the image to the library, assigning it to contact or printing it out via AirPrint
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8)
            else {
                print("No image found")
                return
        }
        /*
         Need to ask permission before saving to device or else crash
         This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSPhotoLibraryAddUsageDescription key with a string value explaining to the user how the app uses this data.
         Need to update info.pist with new row => Privacy - Photo Library Additions Usage Description
         */
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem  = navigationItem.rightBarButtonItem // need popover for iPad
        present(vc, animated: true)
    }
    
}
