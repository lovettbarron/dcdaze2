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
    @IBOutlet var cardView: UIView!

    
    func useCard(card:Card) {
        // Fix the #()@#$ constraint
        
//        let widthConstraint = NSLayoutConstraint(
//            item: self,
//            attribute: NSLayoutAttribute.Width,
//            relatedBy: NSLayoutRelation.Equal,
//            toItem: nil,
//            attribute: NSLayoutAttribute.NotAnAttribute,
//            multiplier: 1,
//            constant: UIScreen.mainScreen().bounds.width-20)
//        
//        NSLayoutConstraint.activateConstraints([widthConstraint])
//        self.translatesAutoresizingMaskIntoConstraints = false

        // Fill in the data
        nameLabel.text = card.name
        descLabel.text = card.desc
        categoryImage.image = card.getCategoryImage()
        drawCardDetails()
    }
    
    func drawCardDetails() {
        var contentView = cardView.frame
        contentView.size.width = UIScreen.mainScreen().bounds.width-20
        print("CONTENTVIEW",contentView)
        self.cardView.frame = contentView
        
        // Card Shadoww
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSizeZero
        self.layer.shadowRadius = 5
        
        // Card Rounding
        self.cardView.layer.cornerRadius = 10
        self.cardView.layer.masksToBounds = true
        self.cardView.layer.borderColor = UIColor(white:0.6, alpha:1).CGColor
        self.cardView.layer.borderWidth = 1
        
        // UIImage
        categoryImage.layer.shadowColor = UIColor.blackColor().CGColor
        categoryImage.layer.shadowOpacity = 0.7
        categoryImage.layer.shadowOffset = CGSizeZero
        categoryImage.layer.shadowRadius = 4
    }
    
    func drawCardTopImage() {
        
    }
    
    class func animate(cell:UITableViewCell) {
        let view = cell.contentView
        view.layer.opacity = 0.1
        UIView.animateWithDuration(1.4) {
            view.layer.opacity = 1
        }
    }
    
}