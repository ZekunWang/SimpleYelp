//
//  Business.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class Business: NSObject {
    let name: String?
    let address: String?
    let imageURL: URL?
    let categories: String?
    let distance: String?
    let ratingImageURL: URL?
    let reviewCount: NSNumber?
    let price: String
    let coordinate: [Double]
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = URL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        var coordinate = [Double]()
        if location != nil {
            let addressArray = location!["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
            
            let coord = location!["coordinate"] as? NSDictionary
            
            let latitude = coord?["latitude"] as? Double
            let longitude = coord?["longitude"] as? Double
            
            if latitude != nil && longitude != nil {
                coordinate.append(latitude!)
                coordinate.append(longitude!)
            }
        }
        self.coordinate = coordinate
        self.address = address
        
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joined(separator: ", ")
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = URL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        
        self.reviewCount = dictionary["review_count"] as? NSNumber
        self.price = Business.getRandomPrice()
    }

    static let prices = ["$", "$$", "$$$", "$$$$"]
    static func getRandomPrice() -> String {
        let index = Int(arc4random_uniform(UInt32(Business.prices.count)))
        return Business.prices[index]
    }
    
    class func businesses(array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            //print("dictionary: \(dictionary)")
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(_ parameters: [String : AnyObject], completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        YelpClient.sharedInstance.searchWithTerm(parameters, completion: completion)
    }
}
