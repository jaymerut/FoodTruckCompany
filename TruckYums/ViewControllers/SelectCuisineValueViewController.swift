//
//  SelectCuisineValueViewController.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/27/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit


class SelectCuisineValueViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    // MARK: - Variables
    public var cuisine: String = ""
    public weak var delegate: SelectCuisineValueDelegate?
    
    private var cuisineArray: [String] = ["American", "BBQ", "Breakfast", "Chinese", "French", "Greek", "Grill", "Hamburger", "Indian", "Italian", "Japanese", "Mexican", "Pizza", "Steak", "Thai"]
    
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
    
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView(frame: .zero)
        picker.delegate = self
        picker.dataSource = self
        
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
    
    // MARK: - Initialization
    private func customInitSelectCuisineValueViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitSelectCuisineValueViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitSelectCuisineValueViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitSelectCuisineValueViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(white: 0.0, alpha: 0.6)
        
        // Setup
        setupSelectCuisineValueViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Private API
    private func setupSelectCuisineValueViewController() {
        
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
            make.left.equalTo(self.contentView.snp.left).offset(40)
            make.right.equalTo(self.contentView.snp.right).offset(-40)
            make.bottom.equalTo(self.buttonClose.snp.top)
            make.height.equalTo(280)
        }
        
        // Picker
        self.viewContainer.addSubview(self.picker)
        self.picker.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewContainer.snp.top)
            make.left.equalTo(self.viewContainer.snp.left)
            make.right.equalTo(self.viewContainer.snp.right)
            make.centerY.equalTo(self.viewContainer.snp.centerY)
            make.bottom.equalTo(self.viewContainer.snp.bottom)
        }
        
        self.updateValues()
    }
    
    private func updateValues() {
        self.picker.selectRow(self.cuisineArray.firstIndex(of: self.cuisine) ?? 0, inComponent: 0, animated: true)
    }
    
    // MARK: UIResponders
    @objc private func buttonClose_TouchUpInside(sender: UIButton) {
        self.delegate?.closedCuisine()
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func buttonApply_TouchUpInside(sender: UIButton) {
        if self.cuisine.count == 0 {
            self.cuisine = self.cuisineArray[0]
        }
        self.delegate?.updateCuisine(cuisine: self.cuisine)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - Public API
    
    // MARK: Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cuisineArray[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cuisineArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.cuisine = self.cuisineArray[row]
    }
}
