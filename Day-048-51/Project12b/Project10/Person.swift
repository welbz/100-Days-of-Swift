//
//  Person.swift
//  Project10
//
//  Created by Welby Jennings on 19/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

// inherits from NSObject so we can access behaviours that cannot get from a Struct

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
