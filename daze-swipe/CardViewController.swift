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
    @IBOutlet var mainView: UIView! // Containing view
    @IBOutlet var nameLabel: UILabel! // Subject title
    @IBOutlet var descLabel: UITextView! // Broader description
    @IBOutlet var dateTimeLabel: UITextView! // Broader description
    @IBOutlet var dazeDescLabel: UITextView! // Broader description
    @IBOutlet var categoryImage: UIImageView! // Top image
    @IBOutlet var highlightImage:UIImageView! // Center image
    @IBOutlet var cardView: UIView! // Card class view
    @IBOutlet var mapView: MKMapView! // Map at bottom
    @IBOutlet var textBgView: UIView! // Background to name label
    @IBOutlet var closeButton: UIImageView! // Closing x at bottom
    @IBOutlet var reserveBtn: UIButton! // Reserve button
    @IBOutlet var sendBtn:UIButton! // Send to friend
    
    var card:Card!
    var sentObj:AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.userInteractionEnabled = true
        let cell = sentObj as? cardCellView
        card = cell?.viewCard
        //        cardBorderColor.backgroundColor = dayController.generateViewColour()
        textBgView.layer.backgroundColor = card.getCategoryColor().CGColor
        textBgView.layer.zPosition = 1
        
        nameLabel.text = card.name!
        nameLabel.font = UIFont(name: "KnockHTF52Cru", size: 34)
        nameLabel.layer.zPosition = 2
        
        dateTimeLabel.text = card.time! + "\n" + card.location!
        descLabel.text = card.desc
        
        dazeDescLabel.text = card.summary!
        
        
        categoryImage.layer.backgroundColor = card.getCategoryPattern().CGColor
        categoryImage.layer.zPosition = 2
        
        highlightImage.image = UIImage(named:"map.png")!.roundImage()

        
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
        
        reserveBtn.layer.shadowColor = UIColor.blackColor().CGColor
        reserveBtn.layer.shadowOpacity = 0.7
        reserveBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
        reserveBtn.layer.shadowRadius = 4
        reserveBtn.layer.cornerRadius = 10
        reserveBtn.layer.masksToBounds = true
        reserveBtn.layer.borderColor = UIColor(white:0.6, alpha:1).CGColor
        reserveBtn.layer.borderWidth = 0
        reserveBtn.layer.backgroundColor = card.getCategoryPattern().CGColor
        
        sendBtn.layer.shadowColor = UIColor.blackColor().CGColor
        sendBtn.layer.shadowOpacity = 0.7
        sendBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
        sendBtn.layer.shadowRadius = 4
        sendBtn.layer.cornerRadius = 10
        sendBtn.layer.masksToBounds = true
        sendBtn.layer.borderColor = UIColor(white:0.6, alpha:1).CGColor
        sendBtn.layer.borderWidth = 0
        sendBtn.layer.backgroundColor = card.getCategoryPattern().CGColor
        sendBtn.layer.opacity = 0.6
        
        mapView.layer.cornerRadius = 10
        
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
    
    @IBAction func openLinkUrl(sender: UIButton) {
        self.performSegueWithIdentifier("openLink", sender: card.link)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as? ReferenceWebView
        dest!.passedURL = card.link
//        dest.transitioningDelegate = self
        //        swipeInteractionController.wireToViewController(destinationViewController)
    }
    
}


extension UIImage
{
    func roundImage() -> UIImage
    {
        let newImage = self.copy() as! UIImage
        let cornerRadius = self.size.height/2
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1.0)
        let bounds = CGRect(origin: CGPointZero, size: self.size)
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).addClip()
        newImage.drawInRect(bounds)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage
    }
}