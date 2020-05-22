import UIKit

// Nil coalescing

/*
 The nil coalescing operator unwraps an optional and returns the value inside if there is one. If there isn’t a value – if the optional was nil – then a default value is used instead. Either way, the result won’t be optional: it will either by the value from inside the optional or the default value used as a back up
 */

func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor"
    } else {
        return nil
        }
    }

let user = username(for: 15) ?? "Anonymous"
/*
 If we call that with ID 15 we’ll get back nil because the user isn’t recognized, but with nil coalescing we can provide a default value of “Anonymous”
 
 That will check the result that comes back from the username() function: if it’s a string then it will be unwrapped and placed into user, but if it has nil inside then “Anonymous” will be used instead
 */
