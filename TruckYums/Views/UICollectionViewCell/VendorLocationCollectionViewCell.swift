//
//  VendorLocationCollectionViewCell.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 7/4/23.
//  Copyright © 2023 truckyums. All rights reserved.
//

import UIKit
import SnapKit

class VendorLocationCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Variables
    public var name: String = ""
    
    private lazy var dateTimeHelper: DateTimeHelper = {
        let helper = DateTimeHelper.init()
        
        return helper
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.init(hex: 0x444444).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    private lazy var labelName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Light", size: 22.0)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.showsExpansionTextWhenTruncated = true
        
        return label
    }()
    
    private lazy var labelCuisine: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 16.0)
        label.text = "Cuisine: "
        
        return label
    }()
    private lazy var labelCuisineValue: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Light", size: 16.0)
        
        return label
    }()
    
    private lazy var labelHours: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 16.0)
        label.text = "Hours: "
        
        return label
    }()
    private lazy var labelHoursValue: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Light", size: 16.0)
        
        return label
    }()
    
    private lazy var imageViewOpenClosed: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return imageView
    }()
    
    // MARK: - Initialization
    private func customInitVendorLocationCollectionViewCell() {
        
        // Setup
        setupVendorLocationCollectionViewCell()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitVendorLocationCollectionViewCell()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customInitVendorLocationCollectionViewCell()
    }
    
    
    
    // MARK: - Private API
    private func setupVendorLocationCollectionViewCell() {
        
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(5)
            make.left.equalTo(self.contentView.snp.left).offset(5)
            make.right.equalTo(self.contentView.snp.right).offset(-5)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
        }
        
        self.containerView.addSubview(self.imageViewOpenClosed)
        self.imageViewOpenClosed.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top).offset(5)
            make.right.equalTo(self.containerView.snp.right).offset(-5)
        }
        
        self.containerView.addSubview(self.labelName)
        self.labelName.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top).offset(5)
            make.left.equalTo(self.containerView.snp.left).offset(5)
            make.right.equalTo(self.imageViewOpenClosed.snp.left).offset(-5)
        }
        
        self.containerView.addSubview(self.labelCuisine)
        self.labelCuisine.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelName.snp.bottom)
            make.left.equalTo(self.containerView.snp.left).offset(5)
        }
        self.containerView.addSubview(self.labelCuisineValue)
        self.labelCuisineValue.snp.makeConstraints { (make) in
            make.left.equalTo(self.labelCuisine.snp.right)
            make.centerY.equalTo(self.labelCuisine.snp.centerY)
        }
        
        self.containerView.addSubview(self.labelHours)
        self.labelHours.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelCuisine.snp.bottom)
            make.left.equalTo(self.containerView.snp.left).offset(5)
        }
        self.containerView.addSubview(self.labelHoursValue)
        self.labelHoursValue.snp.makeConstraints { (make) in
            make.left.equalTo(self.labelHours.snp.right)
            make.centerY.equalTo(self.labelHours.snp.centerY)
        }
    }
    
    
    // MARK: - Public API
    public func update(_ model: VendorLocation) {
        self.labelName.text = model.name
        self.imageViewOpenClosed.image = self.retrieveOpenClosedImage(weeklyHours: model.weeklyHours)
        self.labelCuisineValue.text = model.cuisine
        self.labelHoursValue.text = model.hours.count > 0 ? model.hours : "Call For Hours"
    }
    
    private func retrieveOpenClosedImage(weeklyHours: [String]) -> UIImage {
        let index = self.dateTimeHelper.retrieveCurrentWeekDayIndex()
        let hours = weeklyHours[index]
        if (self.dateTimeHelper.isHoursOpen(hours: hours)) {
            return UIImage(named: "image_open_sign")!
        } else {
            return UIImage(named: "image_closed_sign")!
        }
    }
}

