//
//  ViewController.swift
//  Project 4
//
//  Created by Welby Jennings on 30/5/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    // is UIViewController which extends UIViewController
    // conforms to WKNavigationDelegate protocol
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "zakemedia.com.au"]
    
    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // add left spacing to align refresh on right // eg Spacer()
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload)) // refresh button
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit() // layout sizes to fit full progressView
        let progressButton = UIBarButtonItem(customView: progressView) // wraps button as UIBarButtonItem in toolbar
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false // toolbar will show
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        // Takes 4 Params
        // who observer is, what property you want to observe, which value and context value
        
        let url = URL(string: "https://" + websites[0])!
               // URL data type can be local files not websites
               // Must be https
               webView.load(URLRequest(url: url)) // wraps url in a URLRequest
               webView.allowsBackForwardNavigationGestures = true // enables left and right swipe
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel)) // hides alert controller
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return } // guard let to be safe
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" { // whether the keyPath parameter is set to estimatedProgress – that is, if the estimatedProgress value of the web view has changed
            progressView.progress = Float(webView.estimatedProgress) // we set the progress property of our progress view to the new estimatedProgress value
            // estimatedProgress is a Double so we need to convert as Float cause doubles hold more decimal places
        }
    }
    
    // WK Navigation Protocol
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url // let url be the url of the navigation to make code easier to read
        
        if let host = url?.host { // unwrap the optional url?.host //if the domain exists pull it out
            for website in websites { // loop thorugh all websites in safe list
                if host.contains(website) { // contains to check each safe website is in the host name
                    decisionHandler(.allow) // if found, we want to allow loading
                    return // safely return and exit method
                }
            }
        }
        
        decisionHandler(.cancel)
        // if the 'if let' fails or it succeeds but safe website does not exist in host
        // contains is better than prefix as mobile sites url could be m.applle.com
    }
}

/*
 Delegation is what's called a programming pattern – a way of writing code – and it's used extensively in iOS. And for good reason: it's easy to understand, easy to use, and extremely flexible.

 A delegate is one thing acting in place of another, effectively answering questions and responding to events on its behalf. In our example, we're using WKWebView: Apple's powerful, flexible and efficient web renderer. But as smart as WKWebView is, it doesn't know (or care) how our application wants to behave, because that's our custom code.
 */
