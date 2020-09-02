//
//  ActionViewController.swift
//  Extension
//
//  Created by Welby Jennings on 1/9/20.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    @IBOutlet var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    
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

}


