//
//  ViewController.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-01.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView : UIView!
    
    var selectedRowIndex: NSIndexPath = NSIndexPath(forRow: -1, inSection: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bounds = UIScreen.mainScreen().bounds
        
        // Instantiate all the views
        let ListOfViews = [
            "yesterdayView": 0,
            "todayView": 1,
            "tomorrowView": 2,
        ]
        
        for (page, order) in ListOfViews {
            let view = storyboard.instantiateViewControllerWithIdentifier("dayView") as! UIViewController
            var frame = view.view.frame
            frame.origin.x = bounds.size.width * CGFloat(order)
            frame.size.width = bounds.size.width
            view.view.frame = frame
            view.view.layer.zPosition = CGFloat(order) // Weird instantiation bug...
            
            // Setting constraints
            
            view.view.backgroundColor = generateViewColour(order)
            
            // Binding to parent
            presentViewController(view, animated: true, completion: nil)
            addChildViewController(view)
            scrollView.addSubview(view.view)
            view.didMoveToParentViewController(self)
            print("Creating table ",page)
        }
        
        scrollView.addGestureRecognizer(scrollView.panGestureRecognizer)
        
        scrollView.contentSize = CGSizeMake(bounds.size.width*CGFloat(ListOfViews.count), 1.0)

        // Set up the constraints
        for (view) in scrollView.subviews {
            
            let widthConstraint = NSLayoutConstraint(
                item: view,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: 320)
            
            
            NSLayoutConstraint.activateConstraints([widthConstraint])
//            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
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
        let screenHeight = screenSize.height
        
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
            return UIColor.orangeColor()
        case 1:
            return UIColor.blueColor()
        case 2:
            return UIColor.greenColor()
        default:
            return UIColor.grayColor()
            
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex.row {
            return 100
        }
        return 70
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

