//
//  ViewController.swift
//  Project28
//
//  Created by Welby Jennings on 29/9/20.
//  https://www.hackingwithswift.com/100/92
// Video 2 - https://www.hackingwithswift.com/read/28/2/the-basic-text-editor
// Video 3 - https://www.hackingwithswift.com/read/28/3/writing-somewhere-safe-the-ios-keychain
// Video 4 - https://www.hackingwithswift.com/read/28/4/touch-to-activate-touch-id-face-id-and-localauthentication
// imported 2 files from github to make it far easier
// See Notes file

import LocalAuthentication
import UIKit

class ViewController: UIViewController {
    
    // 1 Video 2
    @IBOutlet var secret: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nothing to see here"
        
        // 3 - Video 2 - Watch for keyboard is appearing or disappearing
        let notificationCenter =  NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        // Tells iOS when keyboard changes or hides so it notifies
        
        // 6 - Video 3 - call save and add observer for leaving app
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
        
    }
    
    // 2 - Video 2
    @IBAction func AuthenticateTapped(_ sender: Any) {
        // 7 - Video 3
        unlockSecretMessage()
        
        // 8 - Video 4 - need to add import LocalAuthentication above - gives access to face ID and touch ID
        let context = LAContext()
        
        // Must be done in objective C error
        var error: NSError?
        
        // pass in where the value is in ram, location in ram
        // NSErrorPointer - pointer to NSError
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!" // only shown to touchID user
            
            // use the policy
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success,
                                                                                                                    authenticationError in
                DispatchQueue.main.async { // push work back to main thread
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        // error - failed to auth
                        // faceID - Need to add info plist Privacy - Face ID Usage Description
                        let ac = UIAlertController(title: "Auth Failed", message: "You could not be verified, please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            // no biometric available
            let ac = UIAlertController(title: "Biometry Unavailable", message: "Your device is not configured for biometric auth.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        
        let keyboardScreenEnd = keyboardValue.cgRectValue // size of keyboard relative to screen (not view)
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, from: view.window) // take it from our window coord to our views coorid, take into account roatation
        
        // keyboard hidden or not
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        } // bottom needs to be height of keyboard minus any safe area insets on bottom of screen eg iPhone X style home indicators
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    // 4 - Video 3
    @objc func unlockSecretMessage() {
        secret.isHidden = false // once unlocked show text
        title = "Secret Stuf!"
        
        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? "" // try and get key from keychain or blank
    }
    
    // 5 - Video 3
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return } // make ure secret is visible before running code or bail out
        
        // write key to Keychain
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder() // make text view stop been active on screen right now
        secret.isHidden = true // when hidden will show button behind it
        title = "Nothing to see here"
    }
}
