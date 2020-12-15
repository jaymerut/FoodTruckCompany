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
        phonenumber = coder.decodeObject(forKey: "phonenumber") as? String ?? ""
        company = coder.decodeObject(forKey: "company") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(email, forKey: "email")
        coder.encode(name, forKey: "name")
        coder.encode(password, forKey: "password")
        coder.encode(phonenumber, forKey: "phonenumber")
        coder.encode(company, forKey: "company")
    }
    
    var email: String = ""
    var name: String = ""
    var password: String = ""
    var phonenumber: String = ""
    var company: String = ""
     
    var dictionary: [String: Any] {
        return [
            "email": email,
            "name": name,
            "password": password,
            "phonenumber": phonenumber
            //"company": company
        ]
    }
    
    override init() {
        super.init()
    }
    init(email: String, name: String, password: String, phonenumber: String) {
        super.init()
        
        self.email = email
        self.name = name
        self.password = password
        self.phonenumber = phonenumber
        //self.company = company
    }
    
    convenience init?(dictionary: [String : Any], id: String) {
        guard   let email = dictionary["email"] as? String,
            let name = dictionary["name"] as? String,
            let password = dictionary["password"] as? String,
            let phonenumber = dictionary["phonenumber"] as? String
            //let company = dictionary["company"] as? String
            else { return nil }
         
        self.init(email: email, name: name, password: password, phonenumber: phonenumber)
    }
}
