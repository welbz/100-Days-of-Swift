//
//  DetailViewController.swift
//  Milestone Project 1
//
//  Created by Welby Jennings on 30/5/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Picture"
        navigationItem.largeTitleDisplayMode = .never
    
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

}
