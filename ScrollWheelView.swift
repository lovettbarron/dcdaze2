//
//  ScrollWheelView.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-07.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import Foundation
import UIKit

class ScrollWheelView:UIView {
    
    @IBOutlet var scrollWheel:UIImageView!
    @IBOutlet var scrollView:UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadView()
    }
    
    func loadView() {
        print("Loading scrollwheel")
        scrollWheel = UIImageView(image: UIImage(named:"ScrollWheel.png"))
        scrollWheel.layer.zPosition = 3
    }
    
    func setToPage(page:Int) {
        switch(page) {
        case 0: rotate(-90)
        case 1: rotate(0)
        case 2: rotate(90)
        default: rotate(0)
        }
    }
    
    func rotate(rad:Int) {
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.99, initialSpringVelocity: 0, options: [], animations: {
            self.scrollWheel.transform = CGAffineTransformMakeRotation(CGFloat(-rad));
            }, completion: nil) // .Repeat, .CurveEaseOut, .Autoreverse
    }

}