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
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://zakemedia.com.au")!
        // URL data type can be local files not websites
        // Must be https
        webView.load(URLRequest(url: url)) // wraps url in a URLRequest
        webView.allowsBackForwardNavigationGestures = true // enables left and right swipe
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "zakemedia.com.au", style: .default, handler: openPage))
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
}

/*
 Delegation is what's called a programming pattern – a way of writing code – and it's used extensively in iOS. And for good reason: it's easy to understand, easy to use, and extremely flexible.

 A delegate is one thing acting in place of another, effectively answering questions and responding to events on its behalf. In our example, we're using WKWebView: Apple's powerful, flexible and efficient web renderer. But as smart as WKWebView is, it doesn't know (or care) how our application wants to behave, because that's our custom code.
 */
