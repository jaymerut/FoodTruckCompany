//
//  GooglePlacesAPI.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/30/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit
import Alamofire

class GooglePlacesAPI: NSObject {
    
    
    // MARK: - Variables
    let session = Alamofire.Session()
    let apiKey = "AIzaSyBXzn94W_bBU0-DarSLbSyJ8w7jBI6MeMI"
    
    
    // MARK: - Initialization
    private func customInitGooglePlacesAPI() {
        
    }
    override init() {
        super.init()
        
        customInitGooglePlacesAPI()
    }
    
    
    
    // MARK: - Private API
    
    
    
    // MARK: - Public API
    public func getSearchNearby(keyword: String, latitude: Double, longitude: Double, radius: Int, completion: @escaping (DataResponse<GooglePlaceNearby, AFError>) -> Void) -> Request {
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        let queryParameters: [String: Any] = [
            "location": "\(latitude),\(longitude)",
            "radius": radius,
            "keyword": keyword,
            "key": apiKey
          ]

      // Set up the call and fire it off
      let request = AF.request(url, parameters: queryParameters).responseDecodable(
        completionHandler: { (response: DataResponse<GooglePlaceNearby, AFError>) in
          // Process the asynchronous response by returning it to the
          // caller; if successful, response includes a deserialized model
          completion(response)
        }
      )

      // Not necessary, but might be nice for debugging purposes
      return request
    }
    
    public func getPlaceDetails(placeID: String, fields: [String], completion: @escaping (DataResponse<GooglePlaceDetails, AFError>) -> Void) -> Request {

        var fieldsString: String = ""
        
        for value in fields {
            if fieldsString.count == 0 {
                fieldsString = value
            } else {
                fieldsString += ",\(value)"
            }
        }
        
        let url = "https://maps.googleapis.com/maps/api/place/details/json"
        let queryParameters: [String: Any] = [
            "place_id": placeID,
            "fields": fieldsString,
            "key": apiKey
          ]
        // Set up the call and fire it off
        let request = AF.request(url, parameters: queryParameters).responseDecodable(
          completionHandler: { (response: DataResponse<GooglePlaceDetails, AFError>) in
            // Process the asynchronous response by returning it to the
            // caller; if successful, response includes a deserialized model
            completion(response)
          }
        )

        // Not necessary, but might be nice for debugging purposes
        return request
      }
    
    
}
