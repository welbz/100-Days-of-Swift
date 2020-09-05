//
//  ViewController.swift
//  Project21
//
//  Created by Welby Jennings on 5/9/20.
//

import UserNotifications
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

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
        registerCategory() // so iOS knows what "alarm" means
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
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
    
    func registerCategory() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self //
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more..", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [], options: [])
        // needs to match above (content.categoryIdentifier = "alert")
        
        // register with center
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // pull out the buried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo
        
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
                case UNNotificationDefaultActionIdentifier:
                    // user swiped to unlock
                    print("Default Identifier")
                
                case "show": // custom Identifier
                    print("Show More Info...")
                
                default:
                    break // all other cases break out
            }
        }
        
        completionHandler() // must be called
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
 
 ***********
 
 You can call registerCategories() wherever you want, but in this project the safest place is probably right at the beginning of the scheduleLocal() method.

 Now that we have registered the “alarm” category with a single button, the last thing to do is implement the didReceive method for the notification center. This is triggered on our view controller because we’re the center’s delegate, so it’s down to us to decide how to handle the notification.

 We attached some customer data to the userInfo property of the notification content, and this is where it gets handed back – it’s your chance to link the notification to whatever app content it relates to.

 When the user acts on a notification you can read its actionIdentifier property to see what they did. We have a single button with the “show” identifier, but there’s also UNNotificationDefaultActionIdentifier that gets sent when the user swiped on the notification to unlock their device and launch the app.

 So: we can pull out our user info then decide what to do based on what the user chose. The method also accepts a completion handler closure that you should call once you’ve finished doing whatever you need to do. This might be much later on, so it’s marked with the @escaping keyword.
 
 */
