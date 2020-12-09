//
//  UIColor+Hex.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/25/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit


extension UIColor {
    
    
    // MARK: - Variables
    
    
    
    // MARK: - Initialization
    public convenience init(hex: UInt32, useAlpha alphaChannel: Bool = false) {
        let mask = 0xFF
        
        let r = Int(hex >> (alphaChannel ? 24 : 16)) & mask
        let g = Int(hex >> (alphaChannel ? 16 : 8)) & mask
        let b = Int(hex >> (alphaChannel ? 8 : 0)) & mask
        let a = alphaChannel ? Int(hex) & mask : 255
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        let alpha = CGFloat(a) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    public convenience init?(hex value: String?, useAlpha alphaChannel: Bool = false) {
        
        // Guard
        guard let string = value else {
            return nil
        }
        
        // Guard
        guard let hex = string.hasPrefix("0x") ? UInt32(string.dropFirst(2), radix: 16) : UInt32(string, radix: 16) else {
            return nil
        }
        
        let mask = 0xFF
        
        let r = Int(hex >> (alphaChannel ? 24 : 16)) & mask
        let g = Int(hex >> (alphaChannel ? 16 : 8)) & mask
        let b = Int(hex >> (alphaChannel ? 8 : 0)) & mask
        let a = alphaChannel ? Int(hex) & mask : 255
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        let alpha = CGFloat(a) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    
    // MARK: - Private API
    
    
    
    // MARK: - Public API
}
