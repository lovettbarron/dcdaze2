//
//  CardViewController.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-13.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CardViewController: UIViewController {
    
    @IBOutlet var cardBorderColor: UIView!
    @IBOutlet var dayController:ViewController!
    @IBOutlet var mainView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descLabel: UITextView!
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var textBgView: UIView!
    @IBOutlet var closeButton: UIImageView!
    
    var card:Card!
    var sentObj:AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.userInteractionEnabled = true
        let cell = sentObj as? cardCellView
        card = cell?.viewCard
        //        cardBorderColor.backgroundColor = dayController.generateViewColour()
        nameLabel.text = card.name!
        nameLabel.font = UIFont(name: "KnockHTF52Cru", size: 34)
        descLabel.text = card.time! + "\n" + card.location!
        //        textBgView.layer.backgroundColor = card.getCategoryColor().CGColor
        //        textBgView.layer.zPosition = 1
        categoryImage.layer.backgroundColor = card.getCategoryPattern().CGColor
        categoryImage.layer.zPosition = 2
        drawCardDetails()

    }
 
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
           //        centerMapOnLocation()
    }
    
    func drawCardDetails() {
//        var contentView = cardView.frame
//        contentView.size.width = UIScreen.mainScreen().bounds.width
//        mainView.frame = contentView
//        
//        // Card Shadoww
        mainView.layer.shadowColor = UIColor.blackColor().CGColor
        mainView.layer.shadowOpacity = 0.7
        mainView.layer.shadowOffset = CGSize(width: 0, height: 4)
        mainView.layer.shadowRadius = 5
//
//        // Card Rounding
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainView.layer.borderColor = UIColor(white:0.6, alpha:1).CGColor
        mainView.layer.borderWidth = 1
//
//        // UIImage
        categoryImage.layer.shadowColor = UIColor.blackColor().CGColor
        categoryImage.layer.shadowOpacity = 0.7
        categoryImage.layer.shadowOffset = CGSize(width: 0, height: 4)
        categoryImage.layer.shadowRadius = 4
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Did recieve a memory warning")
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    
    
    @IBAction func dismissButtonTapped(sender: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("Tap closed view")
    }
    
    @IBAction func dismissButtonClosed(sender: UIPinchGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("Squished view")
    }
    
    @IBAction func dismissButtonSwipe(sender: UISwipeGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("swipe view")
    }
    
}