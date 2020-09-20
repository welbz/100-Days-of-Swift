import UIKit

// Project 24
// https://www.hackingwithswift.com/100/80

// Video 1
// Strings are not arrays - https://www.hackingwithswift.com/read/24/2/strings-are-not-arrays


let name = "Welby"

for letter in name {
    print("give me a \(letter)")
}


// we can’t read individual letters from the string. So, this code won’t work
// print(name[3])
/*
 The reason for this is that letters in a string aren’t just a series of alphabetical characters – they can contain accents such as á, é, í, ó, or ú, they can contain combining marks that generate wholly new characters by building up symbols, or they can even be emoji.

 Because of this, if you want to read the fourth character of name you need to start at the beginning and count through each letter until you come to the one you’re looking for:
 */

let letter = name[name.index(name.startIndex, offsetBy: 3)]
/*
go through "name" string
pull out characters
read index inside the name starting at start of the String
counting forward by 3 chars
*/

// Apple could change this easily enough by adding a rather complex extension like this

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: 1)])
    }
}
// subscript method can read into Strings, Arrays and Dicts
// now applies to all Strings

let letter2 = name[3]

/*
However, it creates the possibility that someone might write code that loops over a string reading individual letters, which they might not realize creates a loop within a loop and has the potential to be slow
 */


// Video 2
// Working with strings in Swift - https://www.hackingwithswift.com/read/24/3/working-with-strings-in-swift
let password = "12345"
password.hasPrefix("123")
password.hasPrefix("456")
print(password)


// We can add extension methods to String to extend the way prefixing and suffixing works
extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    // if we dont have prefix return as is
    // if we do have prefix, drop prefix from String and send that back
    
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
    // if we dont have suffix return as is
    // if we do have suffix drop last from String
}
// That uses the dropFirst() and dropLast() method of String, which removes a certain number of letters from either end of the string



// capitalized property that gives the first letter of each word a capital letter
let weather = "it's going to rain"
print(weather.capitalized)

extension String {
    var capitaliszedFirst: String {
        guard let  firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}
/*
 One thing you can’t see in that is an interesting subtlety of working with strings: individual letters in strings aren’t instances of String, but are instead instances of Character – a dedicated type for holding single-letters of a string.

 So, that uppercased() method is actually a method on Character rather than String. However, where things get really interesting is that Character.uppercased() actually returns a string, not an uppercased Character. The reason is simple: language is complicated, and although many languages have one-to-one mappings between lowercase and uppercase characters, some do not.

 For example, in English “a” maps to “A”, “b” to “B”, and so on, but in German “ß” becomes “SS” when uppercased. “SS” is clearly two separate letters, so uppercased() has no choice but to return a string.
 */


// One last useful method of strings is contains(), which returns true if it contains another string
let input = "Swift is like Objective-C without the C"
input.contains("Swift")


let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift")

extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
             return true
            }
        }
        return false
    }
}

input.containsAny(of: languages)




// method called contains(where:)
// This lets us provide a closure that accepts an element from the array as its only parameter and returns true or false depending on whatever condition we decide we want. This closure gets run on all the items in the array until one returns true, at which point it stops

languages.contains(where: input.contains)

/* contains(where:) will call its closure once for every element in the languages array until it finds one that returns true, at which point it stops.

In that code we’re passing input.contains as the closure that contains(where:) should run. This means Swift will call input.contains("Python") and get back false, then it will call input.contains("Ruby") and get back false again, and finally call input.contains("Swift") and get back true – then stop there.

So, because the contains() method of strings has the exact same signature that contains(where:) expects (take a string and return a Boolean)
*/




// Video 3
// Formatting strings with NSAttributedString - https://www.hackingwithswift.com/read/24/4/formatting-strings-with-nsattributedstring

let string = "This is a test string"

let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]
// dictionary

let atributedString = NSAttributedString(string: string, attributes: attributes)
// Click box button on ride side to see how it looks


// NSMutableAttributedString
let atributedString2 = NSMutableAttributedString(string: string)

atributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
atributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 6, length: 2))
atributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
atributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
atributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))
// Click box button on ride side to see how it looks

/*
Other available options:
NSAttributedString.Key.underlineStyle
NSAttributedString.Key.underlineColor
NSAttributedString.Key.strikethroughStyle
NSAttributedString.Key.strikethroughColor

 NSAttributedString.Key.paragraphStyle
 Set .paragraphStyle to an instance of NSMutableParagraphStyle to control text alignment and spacing.

NSAttributedString.Key.link
Set .link to be a URL to make clickable links in your strings.
 */


// UILabel, UITextField, UITextView, UIButton, UINavigationBar, and more all support attributed strings just as well as regular strings.

// For a label you would just use attributedText rather than text, and UIKit takes care of the rest.
