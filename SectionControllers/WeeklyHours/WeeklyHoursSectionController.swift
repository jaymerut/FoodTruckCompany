//
//  WeeklyHoursSectionController.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 3/13/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

import UIKit


class WeeklyHoursSectionController: ListSectionController {
    
    
    // MARK: - Variables
    private var weeklyHours: WeeklyHours = WeeklyHours.init()
    let daysOfWeek: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    
    // MARK: - Initialization
    private func customInitWeeklyHoursSectionController() {
        
    }
    override init() {
        super.init()
        
        customInitWeeklyHoursSectionController()
    }
    
    
    
    // MARK: - Private API
    // MARK: ListSectionController
    internal override func numberOfItems() -> Int {
        return self.weeklyHours.hours.count
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 100)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: WeeklyHoursCollectionViewCell = (self.collectionContext?.dequeueReusableCell(of: WeeklyHoursCollectionViewCell.self, for: self, at: index))! as! WeeklyHoursCollectionViewCell
        
        cell.hours = self.weeklyHours.hours[index]
        cell.day = self.daysOfWeek[index]
        
        cell.update()
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.weeklyHours = object as! WeeklyHours
    }
    internal override func didSelectItem(at index: Int) {
        
    }
    
    
    // MARK: - Public API
    
    
    
}

class WeeklyHours: NSObject, ListDiffable {
    
    public var hours: [String] = [String]()
    
    // MARK: - Initialization
    private func customInitWeeklyHours() {
        
    }
    override init() {
        super.init()
        
        customInitWeeklyHours()
    }
    
    init(withHours: [String]) {
        super.init()
        
        self.hours = withHours
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.diffIdentifier().isEqual(object?.diffIdentifier())
    }
}
