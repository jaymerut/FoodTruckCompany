//
//  MoreHoursCollectionViewCell.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/21/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

import UIKit


class MoreHoursCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Variables
    public var hours: String = ""
    
    private lazy var dateTimeHelper: DateTimeHelper = {
        let helper = DateTimeHelper()
        
        return helper
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.borderColor = UIColor.init(hex: 0x444444).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var labelHours: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Light", size: 20.0)
        
        return label
    }()
    
    // MARK: - Initialization
    private func customInitMoreHoursCollectionViewCell() {
        
        // Setup
        setupMoreHoursCollectionViewCell()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitMoreHoursCollectionViewCell()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customInitMoreHoursCollectionViewCell()
    }
    
    
    
    // MARK: - Private API
    private func setupMoreHoursCollectionViewCell() {
        
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
        
        self.containerView.addSubview(self.labelHours)
        self.labelHours.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top)
            make.left.equalTo(self.containerView.snp.left).offset(5)
            make.bottom.equalTo(self.containerView.snp.bottom)
        }
        
        
    }
    
    
    // MARK: - Public API
    public func update() {
        self.labelHours.text = self.hours
        
        if self.hours.range(of: self.dateTimeHelper.retrieveCurrentWeekDay()) != nil {
            self.containerView.backgroundColor = UIColor.init(hex: 0x055e86)
            self.labelHours.textColor = .white
            self.labelHours.font = UIFont.init(name: "Teko-Regular", size: 20.0)
            self.containerView.layer.borderColor = UIColor.init(hex: 0x055e86).cgColor
        }
    }
    
    
}
