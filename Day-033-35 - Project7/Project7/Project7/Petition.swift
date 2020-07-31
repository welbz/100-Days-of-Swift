//
//  Petition.swift
//  Project7
//
//  Created by Welby Jennings on 12/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import Foundation

// JSON – JavaScript Object Notatio

struct Petition: Codable, Equatable { // Conforms to Codable
    var title: String
    var body: String
    var signatureCount: Int
}
