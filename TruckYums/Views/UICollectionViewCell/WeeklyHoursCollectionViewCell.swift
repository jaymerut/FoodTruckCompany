//
//  WeeklyHoursCollectionViewCell.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 3/13/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

import UIKit


class WeeklyHoursCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Variables
    public var hours: String = "12:00 AM - 11:59 PM"
    public var day: String = ""
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    
    private lazy var labelDayOfWeek: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        
        return label
    }()
    
    private lazy var labelHyphen: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Medium", size: 20.0)
        label.text = "-"
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var datePickerFrom: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .time
        picker.tintColor = .black
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .compact
        }
        
        return picker
    }()
    private lazy var datePickerTo: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .time
        picker.tintColor = .black
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .compact
        }
        
        return picker
    }()
    
    private lazy var segmentedControlOpenClose: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Open", "Closed"])
        control.backgroundColor = UIColor.gray
        control.selectedSegmentTintColor = UIColor.init(hex: "0xACC649")
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        control.setTitleTextAttributes(titleTextAttributes, for:.normal)
        control.setTitleTextAttributes(titleTextAttributes, for:.selected)
        
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        control.selectedSegmentIndex = 0;
        
        return control
    }()
    
    private lazy var dateTimeHelper: DateTimeHelper = {
        let helper = DateTimeHelper.init()
        
        return helper
    }()
    
    // MARK: - Initialization
    private func customInitWeeklyHoursCollectionViewCell() {
        
        // Setup
        setupWeeklyHoursCollectionViewCell()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitWeeklyHoursCollectionViewCell()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customInitWeeklyHoursCollectionViewCell()
    }
    
    
    
    // MARK: - Private API
    private func setupWeeklyHoursCollectionViewCell() {
        
        // Container View
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
        }
        
        // DayOfWeek Label
        self.containerView.addSubview(self.labelDayOfWeek)
        self.labelDayOfWeek.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top)
            make.left.equalTo(self.containerView.snp.left)
        }
        
        // Date Picker From
        self.containerView.addSubview(self.datePickerFrom)
        self.datePickerFrom.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelDayOfWeek.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.bottom.equalTo(self.containerView.snp.bottom)
            make.width.equalTo(95)
        }
        
        // Hyphen Label
        self.containerView.addSubview(self.labelHyphen)
        self.labelHyphen.snp.makeConstraints { (make) in
            make.left.equalTo(self.datePickerFrom.snp.right).offset(2)
            make.centerY.equalTo(self.datePickerFrom.snp.centerY)
        }
        
        // Date Picker To
        self.containerView.addSubview(self.datePickerTo)
        self.datePickerTo.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelDayOfWeek.snp.bottom).offset(10)
            make.left.equalTo(self.labelHyphen.snp.right).offset(2)
            make.bottom.equalTo(self.containerView.snp.bottom)
            make.width.equalTo(95)
        }
        
        // Segmented Control OpenClose
        self.containerView.addSubview(self.segmentedControlOpenClose)
        self.segmentedControlOpenClose.snp.makeConstraints { (make) in
            make.left.equalTo(self.datePickerTo.snp.right).offset(5)
            make.centerY.equalTo(self.datePickerTo.snp.centerY)
            make.right.equalTo(self.containerView.snp.right)
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.segmentedControlOpenClose.selectedSegmentTintColor = UIColor.init(hex: "0xACC649")
        } else {
            self.segmentedControlOpenClose.selectedSegmentTintColor = UIColor.init(hex: "0xB30000")
        }
        self.datePickerTo.isEnabled = sender.selectedSegmentIndex == 0
        self.datePickerFrom.isEnabled = sender.selectedSegmentIndex == 0
    }
    
    // MARK: - Public API
    public func update() {
        self.labelDayOfWeek.text = self.day
        
        if (self.hours.count == 0) {
            self.hours = "12:00 AM - 11:59 PM"
        }
        self.datePickerFrom.date = self.dateTimeHelper.extractFromHours(hours: self.hours)
        self.datePickerTo.date = self.dateTimeHelper.extractToHours(hours: self.hours)
    }
    
    
}
