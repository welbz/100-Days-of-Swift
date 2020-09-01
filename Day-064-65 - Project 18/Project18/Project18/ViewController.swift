//
//  ViewController.swift
//  Project18
//
//  Created by Welby Jennings on 27/8/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Prints
        print("Im inside the viewDidLoad method")
        
        print(1,2,3,4,5, separator: "-")
        // 1-2-3 etc
        
        print("Some message ", terminator: "")
        // 1-2-3 etc
        
        print(1,2,3,4,5, separator: "+", terminator: "\n")
        // 1-2-3 etc
        
        //MARK: - Breakpoints
        // (lldb) can type after lldb eg p i
        for i in 1...100 {
            print("Got number \(i).")
        }
        
        // conditional breakpoint. Right click => edit breakpoint to add condition
        for n in 1...100 {
            print("Got number \(n).")
        }
        
        //MARK: - Assertions
        // Only used while debugging - removed from app when deployed
        assert(1 == 1, "Math failure!") // will pass
        assert(1 == 2, "Math failure!") // will fail
        
        //Method Assertion
        assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing!")
        
        //MARK: - View debugging
        // Run project and click two rectangle icon
        
        /*
         in Xcode go to the Debug menu and choose View Debugging > Capture View Hierarchy. After a few seconds of thinking, Xcode will show you a screenshot of your app’s UI.

         Here’s the clever part: if you click and drag inside the hierarchy display, you'll see you're actually viewing a 3D representation of your view, which means you can look behind the layers to see what else is there. The hierarchy automatically puts some depth between each of its views, so they appear to pop off the canvas as you rotate them.

         This debug mode is perfect for times when you know you've placed your view but for some reason can't see it – often you'll find the view is behind something else by accident.
         */
        
    }

    func myReallySlowMethod() -> Bool {
        return false
    }

}

//MARK: - Assertions - Notes
/*
 One level up from print() are assertions, which are debug-only checks that will force your app to crash if a specific condition isn't true
 
 On the surface, that sounds terrible: why would you want your app to crash? There are two reasons.
 
 First, sometimes making your app crash is the Least Bad Option: if something has gone catastrophically wrong – if some fundamentally important file is not where it should be – then it may be the case that continuing your app will cause irreparable harm to user data, in which case crashing, while a bad result, is better than losing data.

 Second, these assertion crashes only happen while you’re debugging. When you build a release version of your app – i.e., when you ship your app to the App Store – Xcode automatically disables your assertions so they won’t reach your users. This means you can set up an extremely strict environment while you’re developing, ensuring that all values are present and correct, without causing problems for real users.
 */
