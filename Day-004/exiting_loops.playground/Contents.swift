import UIKit

// Exiting loops

var countDown = 10

while countDown >= 0 {
    print(countDown)
    
    if countDown == 4 {
        print("Im bored lets go!")
         break
    }
    
    countDown -= 1
}

print("Blast off!")
