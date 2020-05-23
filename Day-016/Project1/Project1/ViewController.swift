//
//  ViewController.swift
//  Project1
//
//  Created by Welby Jennings on 23/5/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
    
        for item in items {
            if item.hasPrefix("nssl") {
                // the is a picture to load!
                pictures.append(item)
            }
        }
        print(pictures)
    }

}

