//
//  User.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/26/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import Foundation

struct User {
    var email: String
    var name: String
    var password: String
     
    var dictionary: [String: Any] {
        return [
            "email": email,
            "name": name,
            "password": password
        ]
    }
}

extension User {
    init?(dictionary: [String : Any], id: String) {
        guard   let email = dictionary["email"] as? String,
            let name = dictionary["name"] as? String,
            let password = dictionary["password"] as? String
            else { return nil }
         
        self.init(email: email, name: name, password: password)
    }
}
