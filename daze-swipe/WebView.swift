//
//  WebView.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-14.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ReferenceWebView: UIViewController,WKNavigationDelegate {
    
    @IBOutlet weak var webview:WKWebView!
    
    var passedURL:NSURL! = NSURL(string:"http://andrewlb.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading webview",passedURL)
//        webview = UIWebView(frame: self.view.bounds)
    }
    
    override func viewDidAppear(animated: Bool) {
        print("WebView did appear")
        let requestObj = NSURLRequest(URL: passedURL!)
        webview.loadRequest(requestObj)
    }
    
    @IBAction func dismissButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: Webview Delegate functions
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("Finished navigating to url",self.webview.URL)
    }
    
}