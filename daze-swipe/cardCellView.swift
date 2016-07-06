//
//  cardCellView.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-01.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import Foundation
import UIKit

class cardCellView: UITableViewCell {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descLabel: UITextView!
    @IBOutlet var categoryImage: UIImageView!

    
    func useCard(card:Card) {
        // Round those corners
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = true;
        
        // Fill in the data
        nameLabel.text = card.name
        descLabel.text = card.desc
        categoryImage.image = card.getCategoryImage()
    }
    
    class func animate(cell:UITableViewCell) {
        let view = cell.contentView
        view.layer.opacity = 0.1
        UIView.animateWithDuration(1.4) {
            view.layer.opacity = 1
        }
    }
    
}