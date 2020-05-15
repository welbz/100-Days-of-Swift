import UIKit

// Static properties and methods

/*
 if we had a Student struct we could create several student instances each with their own properties and methods
 */

struct Student {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

//
let welby = Student.init(name: "Welby")
let bree = Student.init(name: "Bree")

// ask Swift to share specific properties and methods across all instances of the struct by declaring them as static

// Now add a static property to the Student struct to store how many students are in the class. Each time we create a new student, we’ll add one to it

struct Student2 {
    var name: String
    static var classSize = 0
    
    init(name: String) {
        self.name = name
        Student2.classSize += 1
    }
}

let bec = Student.init(name: "Bec")
let amy = Student.init(name: "Amy")

// Because the classSize property belongs to the struct itself rather than instances of the struct, we need to read it using Student2.classSize
print(Student2.classSize)
