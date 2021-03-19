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
    public func retrieveCurrentWeekDayIndex() -> Int {
        let currentWeekDay = self.retrieveCurrentWeekDay()
        
        if currentWeekDay == "Monday" {
            return 0
        } else if currentWeekDay == "Tuesday" {
            return 1
        } else if currentWeekDay == "Wednesday" {
            return 2
        } else if currentWeekDay == "Thursday" {
            return 3
        } else if currentWeekDay == "Friday" {
            return 4
        } else if currentWeekDay == "Saturday" {
            return 5
        } else if currentWeekDay == "Sunday" {
            return 6
        }
        
        return 0
    }
    public func retrieveWeekDayFromIndex(index: Int) -> String {
        if index == 0 {
            return "Monday"
        } else if index == 1 {
            return "Tuesday"
        } else if index == 2 {
            return "Wednesday"
        } else if index == 3 {
            return "Thursday"
        } else if index == 4 {
            return "Friday"
        } else if index == 5 {
            return "Saturday"
        } else if index == 6 {
            return "Sunday"
        }
        
        return "Monday"
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
    
    public func convertDateToString(date: Date) -> String {
        self.dateFormatter.dateFormat = "h:mm a"
        let dateString = self.dateFormatter.string(from: date)
        
        return dateString
    }
    
    public func isHoursOpen(hours: String) -> Bool {
        if (hours == "") {
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
