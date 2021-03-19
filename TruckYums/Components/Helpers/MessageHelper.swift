//
//  MessageHelper.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 3/13/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

import UIKit


class MessageHelper: NSObject {
    
    
    // MARK: - Variables
    
    
    
    // MARK: - Initialization
    private func customInitMessageHelper() {
        
    }
    override init() {
        super.init()
        
        customInitMessageHelper()
    }
    
    
    
    // MARK: - Private API
    
    
    
    // MARK: - Public API
    public func displayMessage(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))

        return alert
    }
    
    
}
