import UIKit

// Dictionary default values

/*
 If you try to read a value from a dictionary using a key that doesn’t exist, Swift will send you back nil – nothing at all. While this might be what you want, there’s an alternative: we can provide the dictionary with a default value to use if we request a missing key.
 */

let favIceCream = [
    "Welby": "Choc",
    "Bree": "Peppermint"
]

favIceCream["Welby"]
favIceCream["Bec"] // does not exist

favIceCream["Bec", default: "Vanilla"] // sets default
