//
//  ViewController.swift
//  Project6b
//
//  Created by Welby Jennings on 8/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false // make constraints by hand
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
//
//        for label in viewsDictionary.keys {
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//            // main view - assigns multiple constraints
//            /*
//             H:|[\(label)]| - VFL
//             H = horizontal layout
//             | symbol = edge of view controller
//             ( labels ) puts label
//             | symbol = edge of view controller
//             */
//        }
//
//        let metrics = ["labelHeight": 88]
//
//        // Vertical
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(==labelHeight@999)]-[label2(==label1)]-[label3(==label1)]-[label4(==label1)]-[label5(==label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
        
        /*
            - means space and 10px by default
         Priority 999
         using "label1" for the height for other labels
        */
        
        var previous: UILabel?
        

        for label in [label1, label2, label3, label4, label5] {
            // MARK: -  Challenge 1 and 2
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            
            // MARK: - Challenge 3
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.2, constant: 10).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true // pins to safe area - now displays below the notch
            }
            
            previous = label // previous becomes the current one for next loop
        }
        
/*
        // Anchors
        for label in [label1, label2, label3, label4, label5] {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true // pins to safe area - now displays below the notch
            }
            
            previous = label // previous becomes the current one for next loop
        }
*/
    
    }
        
}

