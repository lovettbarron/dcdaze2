////
////  ScrollWheelView.swift
////  daze-swipe
////
////  Created by Andrew Lovett Barron on 2016-07-07.
////  Copyright © 2016 RelayStudio. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class ScrollWheelView:UIView {
//    
//    @IBOutlet var scrollWheel:UIImage!
//    @IBOutlet var scrollView:UIScrollView!
//    
//    func setToPage(page:Int) {
//        switch(page) {
//        case 0: rotate(-90)
//        case 1: rotate(0)
//        case 2: rotate(90)
//        default: rotate(0)
//        }
//    }
//    
//    func rotate(rad:Int) {
//        let transitionOptions = UIViewAnimationOptions.CurveEaseIn
//
//        UIView.transitionWithView(scrollWheel, duration: 1.0, options: transitionOptions, animations: {
//            
//            
//            }, completion: { finished in
//                // any code entered here will be applied
//                // .once the animation has completed
//        })
//    }
//
//}