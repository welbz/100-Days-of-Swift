//
//  ViewController.swift
//  Project21
//
//  Created by Welby Jennings on 5/9/20.
//

import UserNotifications
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    // Request permissions to show notications
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        // trailing closure syntax
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted,
            error in
            if granted {
                print("Yay!")
            } else {
                print("Oh No!")
            }
        }
    }
    
    @objc func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm."
        content.categoryIdentifier = "alert"
        content.userInfo = ["customData": "Fizzbuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10 //10am
        dateComponents.minute = 30 //1030am
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true) //repeats 1030 every morning
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) //repeats Every 5 seconds
        // Hardware => ⌘ L to lock simulator screen
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}

//MARK: - NOTES
/*
 First, you can't post messages to the user's lock screen unless you have their permission.
 
 So, in order to send local notifications in our app, we first need to request permission, and that's what we'll put in the registerLocal() method. You register your settings based on what you actually need, and that's done with a method called requestAuthorization() on UNUserNotificationCenter.
 
 ***********
 
 Helpful tip:
    if you want to test allowing or denying permission, just reset the simulator and run the app again to get a clean slate.
    Choose the Hardware menu then “Erase all Content and Settings" to make this happen.
 */
