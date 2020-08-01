//
//  DetailViewController.swift
//  Project10
//
//  Created by Welby Jennings on 26/7/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
   
    var selectedImage: String? // optional since it wont exist when view is created
    var imageCaption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(imageCaption ?? "Picture")"

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad) // if no image wont run
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
    
}
