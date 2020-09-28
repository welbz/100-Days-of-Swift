//
//  ViewController.swift
//  Project28
//
//  Created by Welby Jennings on 29/9/20.
//  https://www.hackingwithswift.com/100/92
// Video 2 - https://www.hackingwithswift.com/read/28/2/the-basic-text-editor

import UIKit

class ViewController: UIViewController {
    
    // 1 Video 2
    @IBOutlet var secret: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 3 - Video 2
        let notificationCenter =  NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        // Tells ios when keyboard changes or hides so it notifies
    }
    
    // 2 - Video 2
    @IBAction func AuthenticateTapped(_ sender: Any) {
        
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
    
}

