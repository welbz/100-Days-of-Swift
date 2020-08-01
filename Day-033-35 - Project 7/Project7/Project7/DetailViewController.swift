//
//  DetailViewController.swift
//  Project7
//
//  Created by Welby Jennings on 12/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make detail view title the object title
        title = detailItem?.title

        guard let detailItem = detailItem else { return }
        
        // Challenge 3
        // html surrounding detailItem
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, inital-scale=1">
        <style> body { font-size: 150%; font-weight: 400; font-family: Sans-Serif; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil) // load custom "html" string from above
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
