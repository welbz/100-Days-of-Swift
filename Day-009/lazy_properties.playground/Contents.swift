import UIKit

// Lazy properties
/*
 As a performance optimization, Swift lets you create some properties only when they are needed.
 As an example, this FamilyTree struct – doesn’t do much, but in theory creating a family tree for someone takes a long time
 */


struct FamilyTree {
    init() {
        print("Creating family Tree!")
    }
}

// Now we might use that FamilyTree struct as a property inside a Person struct

struct Person {
    var name: String
    lazy var familytree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
}

var welby = Person(name: "Welby")

// But what if we didn’t always need the family tree for a particular person
// We can add the lazy keyword to the familyTree property, then Swift will only create the FamilyTree struct when it’s first accessed
// So, if you want to see the “Creating family tree!” message, you need to access the property at least once

welby.familytree
