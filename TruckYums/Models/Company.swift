//
//  Company.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/26/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import Foundation

struct Company {
    var name: String
    var latitude: Double
    var longitude: Double
    var linkedwith: String
    var venderverified: Bool
    var cuisine: String
    var phonenumber: String
    var siteurl: String
    var lastupdated: String
    var hours: String
    
     
    var dictionary: [String: Any] {
        return [
            "name": name,
            "latitude": latitude,
            "longitude": longitude,
            "linkedwith": linkedwith,
            "venderverified": venderverified,
            "cuisine": cuisine,
            "phonenumber": phonenumber,
            "siteurl": siteurl,
            "lastupdated": lastupdated,
            "hours": hours
        ]
    }
}

extension Company {
    init?() {
        self.init()
    }
    init?(dictionary: [String : Any], id: String) {
        guard   let name = dictionary["name"] as? String,
            let latitude = dictionary["latitude"] as? Double,
            let longitude = dictionary["longitude"] as? Double,
            let linkedwith = dictionary["linkedwith"] as? String,
            let venderverified = dictionary["venderverified"] as? Bool,
            let cuisine = dictionary["cuisine"] as? String,
            let phonenumber = dictionary["phonenumber"] as? String,
            let siteurl = dictionary["siteurl"] as? String,
            let lastupdated = dictionary["lastupdated"] as? String,
            let hours = dictionary["hours"] as? String
            else { return nil }
         
        self.init(name: name, latitude: latitude, longitude: longitude, linkedwith: linkedwith, venderverified: venderverified, cuisine: cuisine, phonenumber: phonenumber, siteurl: siteurl, lastupdated: lastupdated, hours: hours)
    }
}
