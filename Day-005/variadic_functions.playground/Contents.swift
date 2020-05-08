import UIKit

// Variadic functions

/*
 Some functions are variadic, which is a fancy way of saying they accept any number of parameters of the same type. The print() function is actually variadic: if you pass lots of parameters, they are all printed on one line with spaces between them:
 */

print("Haters", "gonna", "hate")


func square (numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
// loop inside func

square(numbers: 1, 2, 3, 4, 5)
// passing in multple numbers
