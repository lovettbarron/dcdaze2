//
//  cardCellView.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-01.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class cardCellView: UITableViewCell {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descLabel: UITextView!
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var mapView: UIImageView!
    @IBOutlet var textBgView: UIView!
    
    var viewCard:Card!
    
    
    func useCard(card:Card) {
        viewCard = card
        viewCard.headlineImage = viewCard.getCategoryImage()
        // Fill in the data
        nameLabel.text = card.name
        nameLabel.font = UIFont(name: "KnockHTF52Cru", size: 34)

        
        descLabel.text = card.time + "\n" + card.location
        textBgView.layer.backgroundColor = card.getCategoryColor().CGColor
        textBgView.layer.zPosition = 1
        categoryImage.layer.backgroundColor = card.getCategoryPattern().CGColor
        categoryImage.layer.zPosition = 2
        drawCardDetails()
        mapView.image = card.mapThumbnail!
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.imageDownloaded(_:)), name:"didUpdateImage", object: nil)

//        centerMapOnLocation()
    }
    
    func drawCardDetails() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        var contentView = cardView.frame
        contentView.size.width = UIScreen.mainScreen().bounds.width
        self.cardView.frame = contentView
        
        // Card Shadoww
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 5
        
        // Card Rounding
        self.cardView.layer.cornerRadius = 10
        self.cardView.layer.masksToBounds = true
        self.cardView.layer.borderColor = UIColor(white:0.6, alpha:1).CGColor
        self.cardView.layer.borderWidth = 1
        
        // UIImage
        categoryImage.layer.shadowColor = UIColor.blackColor().CGColor
        categoryImage.layer.shadowOpacity = 0.7
        categoryImage.layer.shadowOffset = CGSize(width: 0, height: 4)
        categoryImage.layer.shadowRadius = 4
    }

//    func centerMapOnLocation() {
//        let location = CLLocation(latitude: 38.9072, longitude: 77.0369)
//        let regionRadius: CLLocationDistance = 1000
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
//                                                                  regionRadius * 2.0, regionRadius * 2.0)
//        mapView.setRegion(coordinateRegion, animated: true)
//    }
    
    func imageDownloaded(notification:NSNotification) {
        print("Got Image update notification")
        self.mapView.reloadInputViews()
        self.mapView.image = self.viewCard.mapThumbnail!
//        self.mapView.contentMode = UIViewContentMode.ScaleAspectFill
//        self.mapView.clipsToBounds = true
    }
    
    class func animate(cell:UITableViewCell) {
        let view = cell.contentView
        view.layer.opacity = 0.1
        UIView.animateWithDuration(1.4) {
            view.layer.opacity = 1
        }
    }
    
    
}

