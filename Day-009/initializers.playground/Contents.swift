import UIKit

// Initializers

/*
 Initializers are special methods that provide different ways to create your struct. All structs come with one by default, called their memberwise initializer – this asks you to provide a value for each property when you create the struct
 */

struct User {
    var username: String
    
    init() {
        username = "Anon"
        print("Creating a new user!")
    }
// We can provide our own initializer to replace the default one. For example, we might want to create all new users as “Anonymous”
    
// You don’t write func before initializers, but you do need to make sure all properties have a value before the initializer ends
    
}

// Now our initializer accepts no parameters, we need to create the struct like this
var user = User()
user.username = "Welby"

