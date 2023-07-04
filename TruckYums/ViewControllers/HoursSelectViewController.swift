//
//  HoursSelectViewController.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/27/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit

class HoursSelectViewController: UIViewController {
    
    // MARK: - Variables
    public var hours: String = ""
    public weak var delegate: HoursSelectDelegate?
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20.0
        
        return view
    }()
    private lazy var viewContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    private lazy var datePickerFrom: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .time
        
        return picker
    }()
    private lazy var datePickerTo: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .time
        
        return picker
    }()
    
    private lazy var buttonApply: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(Constants.darkGreenTextColor, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Teko-Regular", size: 18.0)
        button.addTarget(self, action: #selector(buttonApply_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = Constants.greenButtonColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 20.0
        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        return button
    }()
    private lazy var buttonClose: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.init(hex: 0x444444), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Teko-Regular", size: 18.0)
        button.addTarget(self, action: #selector(buttonClose_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = UIColor.init(hex: 0xCCCCCC)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20.0
        button.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        return button
    }()
    
    private lazy var dateTimeHelper: DateTimeHelper = {
        let helper = DateTimeHelper.init()
        
        return helper
    }()
    
    // MARK: - Initialization
    private func customInitHoursSelectViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitHoursSelectViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitHoursSelectViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitHoursSelectViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(white: 0.0, alpha: 0.6)
        
        // Setup
        setupHoursSelectViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Private API
    private func setupHoursSelectViewController() {
        
        // Content View
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX);
            make.centerY.equalTo(self.view.snp.centerY);
            make.left.equalTo(self.view.snp.left).offset(10);
            make.right.equalTo(self.view.snp.right).inset(10);
            make.height.equalTo(0).priority(250);
        }
        
        // Apply Button
        self.contentView.addSubview(self.buttonApply)
        self.buttonApply.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.centerX)
            make.height.equalTo(50)
        }
        
        // Close Button
        self.contentView.addSubview(self.buttonClose)
        self.buttonClose.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.centerX)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(50)
        }
        
        
        // View Container
        self.contentView.addSubview(self.viewContainer)
        self.viewContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.bottom.equalTo(self.buttonClose.snp.top)
            make.height.equalTo(140)
        }
        
        // Date Picker From
        self.viewContainer.addSubview(self.datePickerFrom)
        self.datePickerFrom.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewContainer.snp.top)
            make.left.equalTo(self.viewContainer.snp.left)
            make.right.equalTo(self.viewContainer.snp.centerX)
            make.centerY.equalTo(self.viewContainer.snp.centerY)
            make.bottom.equalTo(self.viewContainer.snp.bottom)
        }
        
        // Date Picker To
        self.viewContainer.addSubview(self.datePickerTo)
        self.datePickerTo.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewContainer.snp.top)
            make.left.equalTo(self.viewContainer.snp.centerX)
            make.right.equalTo(self.viewContainer.snp.right)
            make.centerY.equalTo(self.viewContainer.snp.centerY)
            make.bottom.equalTo(self.viewContainer.snp.bottom)
        }
        
        self.updateValues()
    }
    
    private func updateValues() {
        if (self.hours.count == 0) {
            self.hours = "6:00 AM - 8:00 PM"
        }
        self.datePickerFrom.date = self.dateTimeHelper.extractFromHours(hours: self.hours)
        self.datePickerTo.date = self.dateTimeHelper.extractToHours(hours: self.hours)
    }
    
    private func getHoursString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let hoursFrom = dateFormatter.string(from: self.datePickerFrom.date)
        let hoursTo = dateFormatter.string(from: self.datePickerTo.date)
        return hoursFrom + " - " + hoursTo
    }
    
    // MARK: UIResponders
    @objc private func buttonClose_TouchUpInside(sender: UIButton) {
        self.delegate?.closedHours()
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func buttonApply_TouchUpInside(sender: UIButton) {
        //self.delegate?.updateHours(hours: self.getHoursString())
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Public API
    
    
    
}
