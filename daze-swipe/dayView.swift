//
//  todayView.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-01.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import Foundation
import UIKit


class dayView: UITableViewController {
    
    var cards: [Card] = [Card]()
    var dayType: String!
    var order:Int!
    
    var selectedCard:Card! = nil
    var selectedCell:cardCellView!

    
    private let OpenCardAnimation = OpenCardAnimationController()
    private let CloseCardAnimation = CloseCardAnimationController()
    
    
    
    // MARK: Init Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // appearance and layout customization
        tableView.estimatedRowHeight = 280
        tableView.scrollEnabled = false
        tableView.alwaysBounceVertical = false
        cards = Card.loadCardsFromFile(dayType)
        
        print("viewDidLoad",dayType)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print("viewDidAppear",dayType)
        animateTableLoading()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidAppear(true)
        animateTableUnloading()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CardClass", forIndexPath: indexPath) as! cardCellView
        let card = cards[indexPath.row]
        
        var tableRect = self.view.frame;
        tableRect.size.width = UIScreen.mainScreen().bounds.width
        tableView.frame = tableRect;
        
        cell.useCard(card)
//        print(cell.nameLabel)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // MARK: Table Overrides
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You Tapped ", indexPath)
        selectedCard = cards[indexPath.row]
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! cardCellView
        selectedCell = currentCell
        self.performSegueWithIdentifier("openCard", sender: currentCell)
        
        
        
//        performSegueWithIdentifier("openCard", sender: self)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if self.tableView.editing {return .Delete}
        return .None
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Triggering prepareForSegue in dayView",dayType)
        print("Sender",sender)
        selectedCell = sender as? cardCellView
        let dest = segue.destinationViewController as! CardViewController
        dest.sentObj = sender
        dest.transitioningDelegate = self
//        swipeInteractionController.wireToViewController(destinationViewController)
    }


    // MARK: Animations
    //////////////////////////
    ////// ALL ANIMATION /////
    //////////////////////////
    
    func animateTableLoading() {
        print("Loading",dayType)
        switch(dayType) {
            case "yesterday":
                animateTableFromTop(true)
                break
            case "today":
                animateTableBlinkIn(true) // placeholder
                break
            case "tomorrow":
                animateTableFromRight(true)
                break
            default:
                animateTableFromTop(true)
                break
        }
    }
    
    func animateTableUnloading() {
        print("Unloading",dayType)
        switch(dayType) {
        case "yesterday":
            animateTableFromTop(false)
            break
        case "today":
            animateTableBlinkIn(false) // placeholder
            break
        case "tomorrow":
            animateTableFromRight(false)
            break
        default:
            animateTableFromTop(false)
            break
        }
    }
    
    func animateTableFromRight(loading:Bool) {
//        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableWidth: CGFloat = tableView.bounds.size.width
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(loading==true ? tableWidth*2 : 0,  0 )
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.0, delay: 0.1 * Double(index), usingSpringWithDamping: 0.99, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(loading==true ? 0 : tableWidth*2, 0);
                }, completion: nil) // .Repeat, .CurveEaseOut, .Autoreverse
            
            index += 1
        }
    }
    
    func animateTableFromTop(loading:Bool) {
//        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, loading==true ? -tableHeight : 0 )
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(0.5, delay: 0.1 * Double(index), usingSpringWithDamping: 0.99, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, loading==true ? 0 : -tableHeight);
                }, completion: nil) // .Repeat, .CurveEaseOut, .Autoreverse
            
            index += 1
            
        }
    }
    
    func animateTableBlinkIn(loading:Bool) {
        //        tableView.reloadData()
        print("BlickAnimation",loading)
        let cells = tableView.visibleCells
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeScale(1.0, loading==true ? 0 : 1.0 )
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(0.5, delay: 0.1 * Double(index), usingSpringWithDamping: 0.99, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeScale(1.0, loading==true ? 1.0 : 0);
                }, completion: nil) // .Repeat, .CurveEaseOut, .Autoreverse
            
            index += 1
            
        }

    }
    
}



// MARK: Extension: Segue
extension dayView: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        print("Calling Animation frame")
        
        
        OpenCardAnimation.originFrame = tableView.frame
        return OpenCardAnimation
    }
    
        func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            CloseCardAnimation.destinationFrame = tableView.frame
            return CloseCardAnimation
        }
    
    //    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    //        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    //    }
}
