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
     
    var dictionary: [String: Any] {
        return [
            "name": name,
            "latitude": latitude,
            "longitude": longitude,
            "linkedwith": linkedwith,
            "venderverified": venderverified
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
            let venderverified = dictionary["venderverified"] as? Bool
            else { return nil }
         
        self.init(name: name, latitude: latitude, longitude: longitude, linkedwith: linkedwith, venderverified: venderverified)
    }
}
