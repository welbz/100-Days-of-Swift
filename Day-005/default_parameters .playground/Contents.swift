import UIKit

// Default parameters

func greet (_ person: String, nicely: Bool = true) {
    if nicely == true {
            print("Hello, \(person)!")
        } else {
            print("Oh no, it's \(person) again...")
        }
    }

greet("Welby") // default true
greet("Welby", nicely: false)
