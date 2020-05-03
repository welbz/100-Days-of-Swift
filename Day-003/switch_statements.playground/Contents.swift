import UIKit

// Switch statements

let weather = "sunny"

switch weather {
case "rain":
    print("Bring an Umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Waer sunscreen")
    fallthrough // If you need execution to continue onto next case use fallthrough
default:
    print("Enjoy your day!")
}
// default is generally required
// This default case is not needed if you already cover all other cases, such as with an enum.

