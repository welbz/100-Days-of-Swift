import UIKit

// Polymorphism

class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
}

class liveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
}
// 1 parent class and 2 sub classes
// That defines three classes: albums, studio albums and live albums, with the latter two both inheriting from Album



// Polymorphism
/*
 Because any instance of LiveAlbum is inherited from Album it can be treated just as either Album or LiveAlbum – it's both at the same time.
 This is "polymorphism,"
 */
var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = liveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]
// array that holds only albums, but put inside it two studio albums and a live album. because they are all descended from the Album class


// Polymorphism - Step Further
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
