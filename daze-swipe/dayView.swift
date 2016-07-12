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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // appearance and layout customization
        tableView.estimatedRowHeight = 280
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.scrollEnabled = false
        tableView.alwaysBounceVertical = false
        cards = Card.loadCardsFromFile(dayType)
        print(dayType,tableView.frame)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CardClass", forIndexPath: indexPath) as! cardCellView
        let card = cards[indexPath.row]
        
        var tableRect = self.view.frame;
        tableRect.size.width = UIScreen.mainScreen().bounds.width
        tableView.frame = tableRect;
        
        cell.useCard(card)
        print(cell.nameLabel)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You Tapped ", indexPath)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if self.tableView.editing {return .Delete}
        return .None
    }

    
    func animateTableFromRight() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.Repeat, .CurveEaseOut, .Autoreverse], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
    func animateTableFromTop() {
        
    }
    
    func animateTableBlinkIn() {
        
    }
    
//    func setupGestureRecognizer() {
//        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dayView.handleDoubleTap(_:)))
//        doubleTap.numberOfTapsRequired = 2
//        self.view.addGestureRecognizer(doubleTap)
//    }
//    
//    func handleDoubleTap(recognizer: UITapGestureRecognizer) {
//      
//    }
    
}
