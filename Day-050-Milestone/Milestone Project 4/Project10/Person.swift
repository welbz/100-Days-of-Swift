//
//  Person.swift
// Milestone Project 4 (From Project 12b)
//
//  Created by Welby Jennings on 19/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

// inherits from NSObject so we can access behaviours that cannot get from a Struct

import UIKit

// Codable - lets read and write this
class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
