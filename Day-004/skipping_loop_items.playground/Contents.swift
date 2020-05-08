import UIKit

// Skipping items in loop
    // You can skip items in a loop using continue

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    print(i)
}

/*
 remainder operator figures out how many times 2 fits into each number in our loop, then returns whatever is left over.
 
 So, if 1 is left over, it means the number is odd, so we can use continue to skip it.
 */
