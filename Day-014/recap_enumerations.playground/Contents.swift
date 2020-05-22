import UIKit

// Enumerations
/*
A way for you to define your own kind of value in Swift
 */

enum WeatherType {
    case sun
    case cloud
    case rain
    case wind
    case snow
}


func getHatersStatus(weather: String) -> String? {
    if weather == "Sunnny" {
        return nil
    } else {
        return "Hate"
    }
}
// String is not good cause weather could be Cloudy


func getHatersStatusEnum(weather: WeatherType) -> String? {
    if weather == WeatherType.sun {
        return nil
    } else {
        return "Hate"
    }
}

getHatersStatusEnum(weather: WeatherType.cloud)
getHatersStatusEnum(weather: WeatherType.sun)


// moved cases to own line and can now .cloud as Swift is using type inferences
func getHatersStatusEnum2(weather: WeatherType) -> String? {
    if weather == .sun {
        return nil
    } else {
        return "Hate"
    }
}
getHatersStatusEnum2(weather: .cloud)

// Enums work great with cases
func getHatersStatusEnum3(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .cloud, .wind:
        return "dislike"
    case .rain:
        return "hate"
    default:
        return "yay!"
    }
}

getHatersStatusEnum3(weather: .snow)
// it doesn't handle the .snow case and Swift wants all cases to be covered.
// need to add a case for it or add a default case




// Enums with additional values
enum WeatherKinds {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

func getStatus(weather: WeatherKinds) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10: // only matches if < 10
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}
// .wind appears in there twice, but the first time is true only if the wind is slower than 10 kilometers per hour. If the wind is 10 or above, that won't match

// The key is that you use let to get hold of the value inside the enum (i.e. to declare a constant name you can reference) then use a where condition to check

// Swift evaluates switch/case from top to bottom until it finds a match. This means that if case .cloud, .wind: appears before case .wind(let speed) where speed < 10: then it will be executed instead
