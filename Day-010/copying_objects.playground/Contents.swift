import UIKit

// Copying objects

/*
 The third difference between classes and structs is how they are copied. When you copy a struct, both the original and the copy are different things – changing one won’t change the other. When you copy a class, both the original and the copy point to the same thing, so changing one does change the other.
 */

// Singer class that has a name property with a default value
class Singer {
    var name = "Taylor Swift"
}


var singer = Singer()
print(singer.name)
// If we create an instance of that class and prints its name, we’ll get “Taylor Swift”

var singerCopy = singer
singerCopy.name = "Justin B"
print(singer.name)
// Now let’s create a second variable from the first one and change its name
// Because of the way classes work, both singer and singerCopy point to the same object in memory, so when we print the singer name again we’ll see “Justin Bieber”




// If was a struct we would get name 2 x
struct Singer2 {
    var name = "Adel"
}

var singer2 = Singer2()
print(singer2.name)

var singerCopy2 = singer2
singerCopy2.name = "Justin T"
print(singer2.name)
