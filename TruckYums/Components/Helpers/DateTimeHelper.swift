//
//  DateTimeHelper.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/28/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit


class DateTimeHelper: NSObject {
    
    
    // MARK: - Variables
    
    
    
    // MARK: - Initialization
    private func customInitDateTimeHelper() {
        
    }
    override init() {
        super.init()
        
        customInitDateTimeHelper()
    }
    
    
    
    // MARK: - Private API
    private func retrieveCurrentTime() -> Date {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        var date = Date()
        let dateString = dateFormatter.string(from: date)
        date = dateFormatter.date(from: dateString) ?? Date.init()
        
        return date
    }
    
    
    // MARK: - Public API
    public func retrieveCurrentDateTime() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy h:mm a"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    public func extractFromHours(hours: String) -> Date {
        let stringComponents = hours.components(separatedBy: " - ")
        let hoursFrom = stringComponents[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: hoursFrom) ?? Date.init()

        return date
    }
    public func extractToHours(hours: String) -> Date {
        let stringComponents = hours.components(separatedBy: " - ")
        let hoursTo = stringComponents[1]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: hoursTo) ?? Date.init()
        
        return date
    }
    
    public func isHoursOpen(hours: String) -> Bool {
        if (hours == "") {
            return true
        }
        let hoursFromDate = self.extractFromHours(hours: hours)
        let hoursToDate = self.extractToHours(hours: hours)
        let currentTime = self.retrieveCurrentTime()
        
        if currentTime > hoursFromDate && currentTime < hoursToDate {
            return true
        }
        
        return false
    }
    
    
}
