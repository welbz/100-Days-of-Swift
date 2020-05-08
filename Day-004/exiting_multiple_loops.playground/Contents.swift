import UIKit

// Exiting multiple loops
    // loop inside a loop is a nested loop

outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
    
        if product == 50 {
            print("Its a bullseye!")
            break outerLoop
            
        }
    } // innerloop
} // outerloop

/*
Breaking both loops
1 - Give outerloop a label
2 - add condition inside innerloop

With a regular break innerloop would break but outerloop will continue
 */
