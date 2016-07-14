//
//  WebView.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-14.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import Foundation
import UIKit

class ReferenceWebView: UIViewController {
    
    @IBOutlet var webview:UIWebView!
    
    var passedURL:NSURL! = NSURL(string:"http://andrewlb.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestObj = NSURLRequest(URL: passedURL!);
        webview.loadRequest(requestObj);
    }
    
    @IBAction func dismissButtonTapped(sender: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
}