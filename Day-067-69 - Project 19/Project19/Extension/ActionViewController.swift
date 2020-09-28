//
//  ActionViewController.swift
//  Extension
//
//  Created by Welby Jennings on 1/9/20.


import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    @IBOutlet var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        // Keyboard fixes
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) {
                    // closure
                    [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else {
                        return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    // main thread
                    // closure inside a closer - dont need to set weak as outer closure has already set weak
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
    }

    @IBAction func done() {
        let item = NSExtensionItem()
            let argument: NSDictionary = ["customJavaScript": script.text]
            let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
            let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
            item.attachments = [customJavaScript]

            extensionContext?.completeRequest(returningItems: [item])
        // That's all the code required to send data back to Safari, at which point it will appear inside the finalize() function in Action.js. From there we can do what we like with it, but in this project the JavaScript we need to write is remarkably simple: we pull the "customJavaScript" value out of the parameters array, then pass it to the JavaScript eval() function, which executes any code it finds
        // See notes below
        
        
        
        // Original code
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        //self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
        
        /*
         Calling completeRequest(returningItems:) on our extension context will cause the extension to be closed, returning back to the parent app. However, it will pass back to the parent app any items that we specify, which in the current code is the same items that were sent in.

         In a Safari extension like ours, the data we return here will be passed in to the finalize() function in the Action.js JavaScript file, so we're going to modify the done() method so that it passes back the text the user entered into our text view.

         To make this work, we need to:

         Create a new NSExtensionItem object that will host our items.
         Create a dictionary containing the key "customJavaScript" and the value of our script.
         Put that dictionary into another dictionary with the key NSExtensionJavaScriptFinalizeArgumentKey.
         Wrap the big dictionary inside an NSItemProvider object with the type identifier kUTTypePropertyList.
         Place that NSItemProvider into our NSExtensionItem as its attachments.
         Call completeRequest(returningItems:), returning our NSExtensionItem.
         */
        
    }
    
    // keyboard fixes
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        // Tells us size of keyboard rect
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        // Get back converted frame, correct size of keyboard, in our rotated screen space
        
        // Check if we are hiding or not
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero // push text in from edges = zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        // Set scroll margin to scrollbar
        script.scrollIndicatorInsets = script.contentInset

        // scroll down to whatever user is straight away if hidden by keyboard
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
    /*
     We can ask to be told when the keyboard state changes by using a new class called NotificationCenter. Behind the scenes, iOS is constantly sending out notifications when things happen – keyboard changing, application moving to the background, as well as any custom events that applications post. We can add ourselves as an observer for certain notifications and a method we name will be called when the notification occurs, and will even be passed any useful information.

     When working with the keyboard, the notifications we care about are keyboardWillHideNotification and keyboardWillChangeFrameNotification. The first will be sent when the keyboard has finished hiding, and the second will be shown when any keyboard state change happens – including showing and hiding, but also orientation, QuickType and more.

     It might sound like we don't need keyboardWillHideNotification if we have keyboardWillChangeFrameNotification, but in my testing just using keyboardWillChangeFrameNotification isn't enough to catch a hardware keyboard being connected. Now, that's an extremely rare case, but we might as well be sure!

     To register ourselves as an observer for a notification, we get a reference to the default notification center. We then use the addObserver() method, which takes four parameters: the object that should receive notifications (it's self), the method that should be called, the notification we want to receive, and the object we want to watch. We're going to pass nil to the last parameter, meaning "we don't care who sends the notification."
     
     The adjustForKeyboard() method is complicated, but that's because it has quite a bit of work to do. First, it will receive a parameter that is of type Notification. This will include the name of the notification as well as a Dictionary containing notification-specific information called userInfo.

     When working with keyboards, the dictionary will contain a key called UIResponder.keyboardFrameEndUserInfoKey telling us the frame of the keyboard after it has finished animating. This will be of type NSValue, which in turn is of type CGRect. The CGRect struct holds both a CGPoint and a CGSize, so it can be used to describe a rectangle.

     One of the quirks of Objective-C was that arrays and dictionaries couldn't contain structures like CGRect, so Apple had a special class called NSValue that acted as a wrapper around structures so they could be put into dictionaries and arrays. That's what's happening here: we're getting an NSValue object, but we know it contains a CGRect inside so we use its cgRectValue property to read that value.

     Once we finally pull out the correct frame of the keyboard, we need to convert the rectangle to our view's co-ordinates. This is because rotation isn't factored into the frame, so if the user is in landscape we'll have the width and height flipped – using the convert() method will fix that.

     The next thing we need to do in the adjustForKeyboard() method is to adjust the contentInset and scrollIndicatorInsets of our text view. These two essentially indent the edges of our text view so that it appears to occupy less space even though its constraints are still edge to edge in the view.

     Finally, we're going to make the text view scroll so that the text entry cursor is visible. If the text view has shrunk this will now be off screen, so scrolling to find it again keeps the user experience intact.


     */

}


