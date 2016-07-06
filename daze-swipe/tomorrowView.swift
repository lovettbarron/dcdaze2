//
//  tomorrowView.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-01.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import Foundation
import UIKit

class tomorrowView: UITableViewController {
    
    
    var cards: [Card] = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // appearance and layout customization
        tableView.estimatedRowHeight = 280
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.scrollEnabled = false
        tableView.alwaysBounceVertical = false
        cards = Card.loadCardsFromFile("tomorrow")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CardClass", forIndexPath: indexPath) as! cardCellView
        let card = cards[indexPath.row]
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
        print(cards.count)
        return cards.count
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    
}
