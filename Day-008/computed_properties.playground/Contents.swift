import UIKit

// Computed properties
/*
 Swift has a different kind of property called a computed property – a property that runs code to figure out its value
 */

struct Sport {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olmypic Sport"
        } else {
            return "\(name) is NOT an Olmypic Sport"
        }
    }
}

let chessBoxing = Sport(name: "Chess Boxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)
