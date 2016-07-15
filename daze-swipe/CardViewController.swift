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

class CardViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
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
    
    // Location objects... This class is getting way too big
    var coordinates:CLLocationCoordinate2D!
    var locationManager: CLLocationManager!
    var myLocMarker:MKCircle!
    
    
    // MARK: Load functions
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.initLocationManager()
        
        closeButton.userInteractionEnabled = true
        
        // Populate interface objects
        let cell = sentObj as? cardCellView
        card = cell?.viewCard
        textBgView.layer.backgroundColor = card.getCategoryColor().CGColor
        textBgView.layer.zPosition = 1
        
        nameLabel.text = card.name!
        nameLabel.font = UIFont(name: "KnockHTF52Cru", size: 34)
        nameLabel.layer.zPosition = 2
        
        dateTimeLabel.text = card.time! + "\n" + card.location!
        descLabel.text = card.desc
        dazeDescLabel.text = card.summary!
        
        // Imaging
        categoryImage.layer.backgroundColor = card.getCategoryPattern().CGColor
        categoryImage.layer.zPosition = 2
        highlightImage.image = card.headlineImage.roundImage()
        
        // Mapping
        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(38.9072, -77.0369), span: MKCoordinateSpanMake(0.02, 0.02)), animated: false)
        findAddressOnMap(card.location)
        drawCardDetails()

    }
 
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
           //        centerMapOnLocation()
    }
    
    // MARK Draw Functions
    func drawCardDetails() {
        // Card Shadoww
        mainView.layer.shadowColor = UIColor.blackColor().CGColor
        mainView.layer.shadowOpacity = 0.7
        mainView.layer.shadowOffset = CGSize(width: 0, height: 4)
        mainView.layer.shadowRadius = 5

        // Card Rounding
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainView.layer.borderColor = UIColor(white:0.6, alpha:1).CGColor
        mainView.layer.borderWidth = 1

        // UIImage
        categoryImage.layer.shadowColor = UIColor.blackColor().CGColor
        categoryImage.layer.shadowOpacity = 0.7
        categoryImage.layer.shadowOffset = CGSize(width: 0, height: 4)
        categoryImage.layer.shadowRadius = 4
        
        // Reserve item
        reserveBtn.layer.shadowColor = UIColor.blackColor().CGColor
        reserveBtn.layer.shadowOpacity = 0.7
        reserveBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
        reserveBtn.layer.shadowRadius = 4
        reserveBtn.layer.cornerRadius = 10
        reserveBtn.layer.masksToBounds = true
        reserveBtn.layer.borderColor = UIColor(white:0.6, alpha:1).CGColor
        reserveBtn.layer.borderWidth = 0
        reserveBtn.layer.backgroundColor = card.getCategoryPattern().CGColor
        
        // Send to a friend
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
        
        // Rounding out Map
        mapView.layer.cornerRadius = 10
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Did recieve a memory warning")
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
   
    // MARK: Location
    
    
    func findAddressOnMap(address:String) {
        let location = address
        let geocoder:CLGeocoder = CLGeocoder();
        geocoder.geocodeAddressString(location) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if placemarks?.count > 0 {
                let topResult:CLPlacemark = placemarks![0];
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult);
                self.coordinates = placemark.coordinate
                self.mapView.addAnnotation(placemark)
                self.mapView.setCenterCoordinate(placemark.coordinate, animated: true)
                //                self.routeToAddress()
            }
        }
    }
    
    func routeToAddress() {
        var myAddress = self.mapView.userLocation.location!.coordinate
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: myAddress, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .Automobile
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blueColor()
        return renderer
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.mapView.removeOverlay(myLocMarker)
        
        let current = locations.last?.coordinate
        print("Updating location",current)
        myLocMarker = MKCircle(centerCoordinate: current!, radius: 10)
        self.mapView.addOverlay(myLocMarker)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    routeToAddress()
                }
            }
        }
    }
    
    // MARK: Actions and Interactions
    
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