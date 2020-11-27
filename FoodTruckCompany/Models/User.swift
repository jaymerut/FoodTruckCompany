//
//  User.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/26/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    required init?(coder: NSCoder) {
        email = coder.decodeObject(forKey: "email") as? String ?? ""
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        password = coder.decodeObject(forKey: "password") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(email, forKey: "email")
        coder.encode(name, forKey: "name")
        coder.encode(password, forKey: "password")
    }
    
    var email: String = ""
    var name: String = ""
    var password: String = ""
     
    var dictionary: [String: Any] {
        return [
            "email": email,
            "name": name,
            "password": password
        ]
    }
    
    override init() {
        super.init()
    }
    init(email: String, name: String, password: String) {
        super.init()
        
        self.email = email
        self.name = name
        self.password = password
    }
    
    convenience init?(dictionary: [String : Any], id: String) {
        guard   let email = dictionary["email"] as? String,
            let name = dictionary["name"] as? String,
            let password = dictionary["password"] as? String
            else { return nil }
         
        self.init(email: email, name: name, password: password)
    }
}
