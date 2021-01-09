//
//  GooglePlaceHelper.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/30/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit


class GooglePlaceHelper: NSObject {
    
    
    // MARK: - Variables
    let dateTimeHelper = DateTimeHelper()
    
    
    // MARK: - Initialization
    private func customInitGooglePlaceHelper() {
        
    }
    override init() {
        super.init()
        
        customInitGooglePlaceHelper()
    }
    
    
    
    // MARK: - Private API
    private func indexOfCurrentWeekDay() -> Int {
        switch self.dateTimeHelper.retrieveCurrentWeekDay() {
        case "Monday":
            return 0
        case "Tuesday":
            return 1
        case "Wednesday":
            return 2
        case "Thursday":
            return 3
        case "Friday":
            return 4
        case "Saturday":
            return 5
        case "Sunday":
            return 6
        default:
            return 0
        }
    }
    private func correctHoursString(hours: String) -> String {
        var components = hours.components(separatedBy: "\(self.dateTimeHelper.retrieveCurrentWeekDay()): ")
        if components.count > 1 {
            components = components[1].components(separatedBy: ",")
            return components[0]
        } else {
            return ""
        }
    }
    
    
    // MARK: - Public API
    public func convertGooglePlaceDetailsToCompany(details: GooglePlaceDetails) -> Company {
        let company = Company.init()
        company.name = details.result.name ?? ""
        company.latitude = details.result.geometry?.location?.lat ?? 0
        company.longitude = details.result.geometry?.location?.lng ?? 0
        company.venderverified = false
        company.phonenumber = details.result.formattedPhoneNumber ?? ""
        company.siteurl = details.result.website ?? ""
        if (details.result.openingHours?.weekdayText?.count ?? 0 > 0) {
            company.hours = self.correctHoursString(hours: details.result.openingHours?.weekdayText?[self.indexOfCurrentWeekDay()] ?? "Closed")
        }
        company.lastupdated = self.dateTimeHelper.retrieveCurrentDateTime()
        company.cuisine = "Call Vendor"
        
        return company
    }
    
    
}
