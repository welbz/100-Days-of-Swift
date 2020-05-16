import UIKit

// Class Example

class VideoGame {
    var hero: String
    var enemy: String
    init(heroName: String, enemyName: String) {
        self.hero = heroName
        self.enemy = enemyName
    }
}
let monkeyIsland = VideoGame(heroName: "Guybrush Threepwood", enemyName: "LeChuck")

/*
For the "self.hero = heroName"
hero is the class property
heroName is the init parameter
 
Note: self is used on the class hero property NOT the init parameter
 */
