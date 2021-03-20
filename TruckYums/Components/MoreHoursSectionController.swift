//
//  MoreHoursSectionController.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/21/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

import UIKit


class MoreHoursSectionController: ListSectionController {
    
    
    // MARK: - Variables
    private var hours: String = ""
    
    // MARK: - Initialization
    private func customInitMoreHoursSectionController() {
        
    }
    override init() {
        super.init()
        
        customInitMoreHoursSectionController()
    }
    
    
    
    // MARK: - Private API
    // MARK: ListSectionController
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 50)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: MoreHoursCollectionViewCell = (self.collectionContext?.dequeueReusableCell(of: MoreHoursCollectionViewCell.self, for: self, at: index))! as! MoreHoursCollectionViewCell
        
        cell.hours = self.hours
        
        cell.update()
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.hours = object as! String
    }
    internal override func didSelectItem(at index: Int) {
        
    }
    
    
    // MARK: - Public API
    
    
    
}
