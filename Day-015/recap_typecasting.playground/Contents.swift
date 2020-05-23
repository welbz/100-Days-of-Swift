import UIKit

// Typecasting
/*
Converting an object of one type to another

    Any?
    - optional downcasting
    - I think this conversion is true but might fail
 
    Any!
    - forced downcasting
    - I know this conversion is true, and I'm happy for my app to crash if I'm wrong
*/


class Album2 {
    var name: String

    init(name: String) {
        self.name = name
    }

    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum2: Album2 {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum2: Album2 {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift2 = StudioAlbum2(name: "Taylor Swift", studio: "The Castles Studios")
var fearless2 = StudioAlbum2(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive2 = LiveAlbum2(name: "iTunes Live from SoHo", location: "New York")


var allAlbums2: [Album2] = [taylorSwift2, fearless2, iTunesLive2]


for album in allAlbums2 {
    print(album.getPerformance())
}
/*
 The allAlbums array holds the type Album, but we know that really it's holding one of the subclasses: StudioAlbum or LiveAlbum.
 Swift doesn't know that, so if you try to write something like
 print(album.studio) it will refuse to build because only StudioAlbum objects have that property
*/


for albumTypecast in allAlbums2 {
    print(albumTypecast.getPerformance())
    
    if let studioAlbum = albumTypecast as? StudioAlbum2 {
        print(studioAlbum.studio)
    } else if let liveAlbum = albumTypecast as? LiveAlbum2 {
        print(liveAlbum.location)
    }
}



// Forced downcasting
// - if you're wrong your program will just crash
var taylorSwift3 = StudioAlbum2(name: "Taylor Swift", studio: "The Castles Studios")
var fearless3 = StudioAlbum2(name: "Speak Now", studio: "Aimeeland Studio")

var allAlbums3: [Album2] = [taylorSwift3, fearless3]

for album3 in allAlbums3 {
    let studioAlbum = album3 as! StudioAlbum2
    print(studioAlbum.studio)
}
// That's not a great example, because if that really were your code you would just change allAlbums so that it had the data type [StudioAlbum]. Still, it shows how forced downcasting works


// Refactored
for album in allAlbums3 as! [StudioAlbum2] {
    print(album.studio)
}
// That no longer needs to downcast every item inside the loop, because it happens when the loop begins. Again, you had better be correct that all items in the array are StudioAlbums, otherwise your code will crash



// Optional downcasting at the array level
// it's tricky because you need to use the nil coalescing operator to ensure there's always a value for the loop
for album in allAlbums3 as? [LiveAlbum2] ?? [LiveAlbum2]() {
    print(album.location)
}
// tries to convert allAlbums to be an array of LiveAlbum objects, but if that fails just create an empty array of live albums and use that instead (ie do nothing)



// Converting common types with initializers
let number = 5
let text = number as! String
// cant force Int into a String


// Shoud be written as
let number2 = 5
let text2 = String(number2) // convert to string first
print(text2)
