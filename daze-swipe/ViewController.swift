//
//  ViewController.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-01.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: DazeScrollView!
    
    var selectedRowIndex: NSIndexPath = NSIndexPath(forRow: -1, inSection: 0)
    
    let bounds = UIScreen.mainScreen().bounds
    
    // Instantiate all the views
    let ListOfViews = [
        "yesterday": 0,
        "today": 1,
        "tomorrow": 2,
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        for (page, order) in ListOfViews {
            let view = storyboard.instantiateViewControllerWithIdentifier("dayView") as! dayView
            view.dayType = page
            var frame = view.view.frame
            frame.origin.x = bounds.size.width * CGFloat(order)
            frame.size.width = bounds.size.width
            view.view.frame = frame
            view.view.layer.zPosition = CGFloat(order) // Weird instantiation bug...
            
            // Setting aestheticz
            view.view.backgroundColor = generateViewColour(order)
            
            // Binding to parent
            presentViewController(view, animated: true, completion: nil)
//            addChildViewController(view)
            scrollView.addSubview(view.view)
            view.didMoveToParentViewController(self)
            print("Creating table ",page)
        }
        
        scrollView.addGestureRecognizer(scrollView.panGestureRecognizer)
        
        scrollView.contentSize = CGSizeMake(bounds.size.width*CGFloat(ListOfViews.count), 1.0)

        // Set up the constraints
//        for (view) in scrollView.subviews {
//            
//            let widthConstraint = NSLayoutConstraint(
//                item: view,
//                attribute: NSLayoutAttribute.Width,
//                relatedBy: NSLayoutRelation.Equal,
//                toItem: nil,
//                attribute: NSLayoutAttribute.NotAnAttribute,
//                multiplier: 1,
//                constant: bounds.size.width)
//            
//            
//            NSLayoutConstraint.activateConstraints([widthConstraint])
////            view.translatesAutoresizingMaskIntoConstraints = false
//        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        moveScrollPointToPage(1)
    }

    func moveScrollPointToPage(page:Int) {
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        
        var scrollpoint:Int
        
        switch(page) {
            case 0: scrollpoint = 0
            case 1: scrollpoint = Int(screenWidth)
            case 2: scrollpoint = Int(screenWidth*2)
            default: scrollpoint = Int(screenWidth)
        }
        
        if (scrollView != nil) {
            scrollView!.setContentOffset(CGPoint(x: scrollpoint,y: 0), animated: true)
        }
    }
    
    func generateViewColour(order:Int) -> UIColor {
        switch(order) {
        case 0 :
            return UIColor(red:0.55, green:0.43, blue:0.87, alpha:1.0)
        case 1:
            return UIColor(red:0.87, green:0.43, blue:0.43, alpha:1.0)
        case 2:
            return UIColor(red:0.58, green:0.87, blue:0.43, alpha:1.0)
        default:
            return UIColor.grayColor()
            
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex.row {
            return 200
        }
        return 200
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("DidSelectRowAt",indexPath)
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CardClass")
        
        print("Calling cell :",cell.reuseIdentifier)
        
        return cell
    }
    
}

