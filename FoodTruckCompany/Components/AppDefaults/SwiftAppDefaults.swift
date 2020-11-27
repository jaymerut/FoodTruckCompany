//
//  SwiftAppDefaults.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/27/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit
import Foundation


class SwiftAppDefaults: NSObject {
    
    
    // MARK: - Variables
    public static let shared: SwiftAppDefaults = SwiftAppDefaults()
    
    private var defaults: UserDefaults
    
    private struct Keys {
            public static let user = "AppDefaults.Keys.user"
    }
    
    public var user: User? {
            get {
                guard let encodedObj = UserDefaults.standard.object(forKey: Keys.user) as? NSData else {
                    return nil
                }
                return NSKeyedUnarchiver.unarchiveObject(with: encodedObj as Data) as! User
            }
            set {
                guard let user = newValue, let encodedObj = NSKeyedArchiver.archivedData(withRootObject: user) as? NSData else {
                    defaults.removeObject(forKey: Keys.user)
                    return
                }
                defaults.set(encodedObj, forKey: Keys.user)
            }
        }
    
    // MARK: - Initialization
    private func customInitSwiftAppDefaults() {
        
    }
    override init() {
        self.defaults = UserDefaults.standard
        super.init()
        
        customInitSwiftAppDefaults()
    }
    
    
    
    // MARK: - Private API
    
    
    
    // MARK: - Public API
    
    
    
}

fileprivate extension UserDefaults {
    
    // String
    func safe(set value: String?, forKey: String) {
        
        guard let value = value else {
            self.removeObject(forKey: forKey)
            return
        }
        
        self.set(value, forKey: forKey)
    }
    
}
