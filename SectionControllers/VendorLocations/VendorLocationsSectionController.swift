//
//  VendorLocationsSectionController.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 7/4/23.
//  Copyright © 2023 truckyums. All rights reserved.
//

import UIKit

protocol VendorLocationsSectionControllerDelegate: AnyObject {
    func navigateToWebView(urlString: String)
}

class VendorLocationsSectionController: ListSectionController {
    
    
    // MARK: - Variables
    private var vendorLocation: VendorLocation = VendorLocation()
    public weak var delegate: VendorLocationsSectionControllerDelegate?
    
    // MARK: - Initialization
    private func customInitVendorLocationsSectionController() {
        
    }
    override init() {
        super.init()
        
        customInitVendorLocationsSectionController()
    }
    init(delegate: VendorLocationsSectionControllerDelegate) {
        super.init()
        
        customInitVendorLocationsSectionController()
        self.delegate = delegate
    }
    
    
    // MARK: - Private API
    // MARK: ListSectionController
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 150)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: VendorLocationCollectionViewCell = (self.collectionContext?.dequeueReusableCell(of: VendorLocationCollectionViewCell.self, for: self, at: index))! as! VendorLocationCollectionViewCell
        
        cell.update(self.vendorLocation)
        cell.navigateToWebView = { urlString in
            self.delegate?.navigateToWebView(urlString: urlString)
        }
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        guard let parsedObject = object as? VendorLocation else {
            return
        }
        self.vendorLocation = parsedObject
    }
    internal override func didSelectItem(at index: Int) {
        
    }
    
    
    // MARK: - Public API
    
}

class VendorLocation: NSObject, ListDiffable {
    
    public var name: String = ""
    public var weeklyHours: [String] = [String]()
    public var cuisine: String = ""
    public var hours: String = ""
    public var phoneNumber: String = ""
    public var distance: Double = 0.0
    public var latitude: Double = 0.0
    public var longitude: Double = 0.0
    public var siteUrl: String = ""
    public var isVerified: Bool = false
    
    // MARK: - Initialization
    private func customInitWeeklyHours() {
        
    }
    override init() {
        super.init()
        
        customInitWeeklyHours()
    }
    
    init(name: String, weeklyHours: [String], cuisine: String, hours: String, phoneNumber: String, distance: Double, latitude: Double, longitude: Double, siteUrl: String, isVerified: Bool) {
        super.init()
        self.name = name
        self.weeklyHours = weeklyHours
        self.cuisine = cuisine
        self.hours = hours
        self.phoneNumber = phoneNumber
        self.distance = distance
        self.latitude = latitude
        self.longitude = longitude
        self.siteUrl = siteUrl
        self.isVerified = isVerified
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.diffIdentifier().isEqual(object?.diffIdentifier())
    }
}

