import UIKit

// Optionals

func getHaterStatus() -> String {
    return "Hate"
}
// must return String



func getHaterStatusOptional() -> String? {
    return "Hate"
}
// might return String / might not


func getHaterStatusWeather(weather: String) -> String? {
    if weather == "Sunny" {
        return nil
    } else {
        return "Hate"
    }
}

/*
var status: String
status = getHaterStatusWeather(weather: "rainy")
// wont run as status is String and getHaterStatusWeather is an optional String
*/


var status2: String?
status2 = getHaterStatusWeather(weather: "rainy")
// will run as both optional
// made the status variable a String?


var status3 = getHaterStatusWeather(weather: "Sunny")
// lets Swift use type inference
// will run - shorthand


func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

// Unwrapping
// 1 - checks weather it has valaue
// 2 if so, it unwraps to non-optional type and runs code

if let unwrappedStatus = status3 {
    // unwrappedStatus contains non optional string
} else {
    // in case you want an else block here you go
}
// checks and unwraps



if let haterStatus = getHaterStatusWeather(weather: "rainy") {
    takeHaterAction(status: haterStatus)
}






// Another Example

func yearAlbumRelease(name: String) -> Int {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    return 0
}
// takes name and returns year it was released

func yearAlbumReleaseOptional(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    return nil
}
// Since 0 is not great to return we should make it optional and return nil
