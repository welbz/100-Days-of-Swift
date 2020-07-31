//
//  Petitions.swift
//  Project7
//
//  Created by Welby Jennings on 12/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import Foundation

 // Need to access the second level of the data structure

struct Petitions: Codable { // Conforms to Codable
    var results: [Petition]
}
