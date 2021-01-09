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
    let dateFormatter = DateFormatter()
    
    
    // MARK: - Initialization
    private func customInitDateTimeHelper() {
        
    }
    override init() {
        super.init()
        
        customInitDateTimeHelper()
    }
    
    
    
    // MARK: - Private API
    private func retrieveCurrentTime() -> Date {
        self.dateFormatter.dateFormat = "h:mm a"
        var date = Date()
        let dateString = self.dateFormatter.string(from: date)
        date = self.dateFormatter.date(from: dateString) ?? Date.init()
        
        return date
    }
    
    
    // MARK: - Public API
    public func retrieveCurrentDateTime() -> String {
        self.dateFormatter.dateFormat = "MMM dd, yyyy h:mm a"
        let date = Date()
        let dateString = self.dateFormatter.string(from: date)
        
        return dateString
    }
    public func retrieveCurrentWeekDay() -> String {
        self.dateFormatter.dateFormat = "EEEE"
        let date = Date()
        let dateString = self.dateFormatter.string(from: date)
        
        return dateString
    }
    
    public func extractFromHours(hours: String) -> Date {
        var stringComponents = hours.components(separatedBy: " - ")
        if stringComponents.count < 2 {
            stringComponents = hours.components(separatedBy: " – ")
        }
        let hoursFrom = stringComponents[0]
        self.dateFormatter.dateFormat = "h:mm a"
        let date = self.dateFormatter.date(from: hoursFrom) ?? Date.init()

        return date
    }
    public func extractToHours(hours: String) -> Date {
        var stringComponents = hours.components(separatedBy: " - ")
        if stringComponents.count < 2 {
            stringComponents = hours.components(separatedBy: " – ")
        }
        let hoursTo = stringComponents[1]
        self.dateFormatter.dateFormat = "h:mm a"
        let date = self.dateFormatter.date(from: hoursTo) ?? Date.init()
        
        return date
    }
    
    public func isHoursOpen(hours: String) -> Bool {
        if (hours == "" || hours.lowercased() == "open 24 hours") {
            return true
        } else if (hours == "Closed") {
            return false
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
