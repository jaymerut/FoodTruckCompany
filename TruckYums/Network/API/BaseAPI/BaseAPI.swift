//
//  BaseAPI.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/30/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit
import Alamofire

class BaseAPI: NSObject {
    
    
    // MARK: - Variables
    
    
    
    // MARK: - Initialization
    private func customInitBaseAPI() {
        
    }
    override init() {
        super.init()
        
        customInitBaseAPI()
    }
    
    
    
    // MARK: - Private API
    
    
    
    // MARK: - Public API
    public func makeAPICall() {
        AF.request(<#T##convertible: URLConvertible##URLConvertible#>)
    }
    
    
}
