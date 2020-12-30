//
//  QueryHelper.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/29/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit
import MapKit


class QueryHelper: NSObject {
    
    
    // MARK: - Variables
    
    
    
    // MARK: - Initialization
    private func customInitQueryHelper() {
        
    }
    override init() {
        super.init()
        
        customInitQueryHelper()
    }
    
    
    
    // MARK: - Private API
    
    
    
    // MARK: - Public API
    public func searchBy(naturalLanguageQuery: String, region: MKCoordinateRegion, coordinates: CLLocationCoordinate2D, completionHandler: @escaping(_ response: MKLocalSearch.Response?, _ error: NSError?) -> Void) {

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = naturalLanguageQuery
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                completionHandler(nil, error as NSError?)

                return
            }

            completionHandler(response, error as NSError?)
        }
    }
    
    
}
