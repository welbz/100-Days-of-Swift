//
//  ViewController.swift
//  Project12
//
//  Created by Welby Jennings on 30/6/20.
// www.hackingwithswift.com/100/48

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // loads when app launches
        let defaults = UserDefaults.standard
        
        // Writing to
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseFaceID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        
        defaults.set("Welby Jennings", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Welby", "Country": "Aus"]
        defaults.set(dict, forKey: "SavedDictionary")
        
        
        
        // Reading from User Defaults
        /*
         UserDefaults - check the return type carefully to ensure you know what you're getting:
         integer(forKey:) returns an integer if the key existed, or 0 if not.
         bool(forKey:) returns a boolean if the key existed, or false if not.
         float(forKey:) returns a float if the key existed, or 0.0 if not.
         double(forKey:) returns a double if the key existed, or 0.0 if not.
         object(forKey:) returns Any? so you need to conditionally typecast it to your data type.
         */
        
        let savedString = defaults.string(forKey: "Name")
        let savedInteger = defaults.integer(forKey: "Age")
        let savedBool = defaults.bool(forKey: "UseFaceID")
        
        // Problematic - need object keys
        // uses typecasting as? and nil coelsiing ??
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        // if SavedArray exists and is a string array, it will be placed into the array constant
        // If it doesn't exist (or if it does exist and isn't a string array), then array gets set to be a new string array
        
        let savedDict = defaults.object(forKey: "SavedDict") as? [String : String] ?? [String: String]()
        
    }


}

