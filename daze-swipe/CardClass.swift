//
//  CardClass.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-01.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

//
//  Card.swift
//  daze-proto
//
//  Created by Andrew Lovett Barron on 2016-06-30.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import Foundation
import UIKit

enum Category: Int {
    case Music = 0
    case Food = 1
    case Event = 2
}

class Card {
    
    let category: Int!
    let name: String!
    let desc: String!
    let location: String!
    let time: String!
    
    init(dictionary:NSDictionary) {
        category = dictionary["category"]   as? Int
        name = dictionary["name"]           as? String
        location = dictionary["location"]   as? String
        time = dictionary["time"]           as? String
        
        // fixup the about text to add newlines
        let unescDesc = dictionary["desc"] as? String
        desc = unescDesc?.stringByReplacingOccurrencesOfString("\\n", withString:"\n", options:[], range:nil)
    }
    
//    func getCategoryImage() -> UIImage {
//        switch(category) {
//        case 0 :
//            return getImageWithColor(UIColor.blueColor(), size: CGSize(width: 100,height: 100))
//        case 1:
//            return getImageWithColor(UIColor.cyanColor(), size: CGSize(width: 100,height: 100))
//        case 2:
//            return getImageWithColor(UIColor.purpleColor(), size: CGSize(width: 100,height: 100))
//        default:
//            return getImageWithColor(UIColor.darkGrayColor(), size: CGSize(width: 100,height: 100))
//            
//        }
//    }
    
    func getCategoryColor() -> UIColor {
        switch(category) {
        case 0 :
            return UIColor.blueColor()
        case 1:
            return UIColor.cyanColor()
        case 2:
            return UIColor.purpleColor()
        default:
            return UIColor.darkGrayColor()
        }
    }
    
    func getCategoryPattern() -> UIColor {
        switch(category) {
        case 0 :
            return UIColor(patternImage: UIImage(named: "Music_pattern Copy.png")!)
        case 1:
            return UIColor(patternImage: UIImage(named: "Food_pattern Copy.png")!)
        case 2:
            return UIColor(patternImage: UIImage(named: "Event_pattern Copy.png")!)
        default:
            return UIColor(patternImage: UIImage(named: "Event_pattern.png")!)
            
        }
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func loadCardsFromFile(day:String) -> [Card]
    {
        var cards:[Card] = []
        let path = NSBundle.mainBundle().pathForResource("dummy", ofType: "json")
        var error:NSError? = nil
        if(error != nil) { print(error) }
        if let data = try? NSData(contentsOfFile: path!, options:[]),
            json = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary,
            card = json![day] as? [NSDictionary] {
            for cardDictionary in card {
                let card = Card(dictionary: cardDictionary)
                cards.append(card)
            }
        }
        return cards
    }
    
}