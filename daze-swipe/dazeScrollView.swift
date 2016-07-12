//
//  dazeScrollView.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-07.
//  Copyright © 2016 RelayStudio. All rights reserved.
//


import UIKit

class DazeScrollView: UIScrollView, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        super.delegate = self
        print("ScrollViewIsActuallyWorking")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.delegate = self
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / UIScreen.mainScreen().bounds.width
        print("On Page ", page)
    }
 
}