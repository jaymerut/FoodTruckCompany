//
//  Company.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/26/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import Foundation

class Company: NSObject, NSCoding {
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        latitude = coder.decodeObject(forKey: "latitude") as? Double ?? 0
        longitude = coder.decodeObject(forKey: "longitude") as? Double ?? 0
        linkedwith = coder.decodeObject(forKey: "linkedwith") as? String ?? ""
        venderverified = coder.decodeObject(forKey: "venderverified") as? Bool ?? false
        cuisine = coder.decodeObject(forKey: "cuisine") as? String ?? ""
        phonenumber = coder.decodeObject(forKey: "phonenumber") as? String ?? ""
        siteurl = coder.decodeObject(forKey: "siteurl") as? String ?? ""
        lastupdated = coder.decodeObject(forKey: "lastupdated") as? String ?? ""
        hours = coder.decodeObject(forKey: "hours") as? String ?? ""
        weeklyhours = coder.decodeObject(forKey: "weeklyhours") as? [String] ?? [String]()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(latitude, forKey: "latitude")
        coder.encode(longitude, forKey: "longitude")
        coder.encode(linkedwith, forKey: "linkedwith")
        coder.encode(venderverified, forKey: "venderverified")
        coder.encode(cuisine, forKey: "cuisine")
        coder.encode(phonenumber, forKey: "phonenumber")
        coder.encode(siteurl, forKey: "siteurl")
        coder.encode(lastupdated, forKey: "lastupdated")
        coder.encode(hours, forKey: "hours")
        coder.encode(weeklyhours, forKey: "weeklyhours")
    }
    
    var name: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    var linkedwith: String = ""
    var venderverified: Bool = false
    var cuisine: String = ""
    var phonenumber: String = ""
    var siteurl: String = ""
    var lastupdated: String = ""
    var hours: String = ""
    var weeklyhours: [String] = [String]()
    
     
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
    
    override init() {
        super.init()
    }
    
    init(name: String, latitude: Double, longitude: Double, linkedwith: String, venderverified: Bool, cuisine: String, phonenumber: String, siteurl: String, lastupdated: String, hours: String) {
        super.init()
        
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.linkedwith = linkedwith
        self.venderverified = venderverified
        self.cuisine = cuisine
        self.phonenumber = phonenumber
        self.siteurl = siteurl
        self.lastupdated = lastupdated
        self.hours = hours
    }
    
    convenience init?(dictionary: [String : Any], id: String) {
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
