import UIKit

// inout parameters
/*
 All parameters passed into a Swift function are constants, so you can’t change them. If you want, you can pass in one or more parameters as inout, which means they can be changed inside your function, and those changes reflect in the original value outside the function.
 */


func doubleInPlace(number: inout Int) {
    number *= 2
}

/*
 To use that, you first need to make a variable integer – you can’t use constant integers with inout, because they might be changed. You also need to pass the parameter to doubleInPlace using an ampersand, &, before its name, which is an explicit recognition that you’re aware it is being used as inout.
 */

var myNum = 2

doubleInPlace(number: &myNum)
// & before its name is recognition that you’re aware it is being used as inout.
