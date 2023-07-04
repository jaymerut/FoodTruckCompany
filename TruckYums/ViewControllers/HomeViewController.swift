//
//  HomeViewController.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 9/13/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit
import SnapKit


class HomeViewController: UIViewController {
    
    
    // MARK: - Variables
    private lazy var labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "TruckYums"
        label.font = UIFont(name: "Teko-Medium", size: 24)
        label.textColor = .white
        
        return label
    }()
    private lazy var imageViewMapPreview: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "home_map_preview")
        
        return imageView
    }()
    private lazy var imageViewFoodTruck: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "home_food_truck")
        
        return imageView
    }()
    
    private lazy var viewOpaque: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.alpha = 0.7
        
        return view
    }()
    private lazy var viewBackgroundContainer: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    private lazy var viewFoodTruckBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.borderColor = Constants.secondaryColor.cgColor
        view.layer.borderWidth = 15
        
        return view
    }()
    
    private lazy var buttonLogin: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Login as Vendor", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        button.backgroundColor = Constants.mainColor
        button.layer.cornerRadius = 32.5
        button.addTarget(self, action: #selector(buttonLogin_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    private lazy var buttonViewPortal: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("View Vendor Portal", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        button.backgroundColor = Constants.mainColor
        button.layer.cornerRadius = 32.5
        button.addTarget(self, action: #selector(buttonViewPortal_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    private lazy var buttonFind: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Find Nearby Food Vendors", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        button.backgroundColor = Constants.mainColor
        button.layer.cornerRadius = 32.5
        button.addTarget(self, action: #selector(buttonFind_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - Initialization
    private func customInitHomeViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitHomeViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitHomeViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitHomeViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.titleView = self.labelTitle
        
        // Setup
        setupHomeViewController()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if SwiftAppDefaults.shared.user == nil {
            self.buttonLogin.isHidden = false
            self.buttonViewPortal.isHidden = true
        } else {
            self.buttonLogin.isHidden = true
            self.buttonViewPortal.isHidden = false
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.viewFoodTruckBackground.layer.cornerRadius = self.viewBackgroundContainer.frame.size.width/2
    }
    
    
    
    // MARK: - Private API
    private func setupHomeViewController() {
        
        // ImageView MapPreview
        self.view.addSubview(self.imageViewMapPreview)
        self.imageViewMapPreview.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        // View Opaque
        self.imageViewMapPreview.addSubview(self.viewOpaque)
        self.viewOpaque.snp.makeConstraints { (make) in
            make.edges.equalTo(self.imageViewMapPreview)
        }
        
        // Button Find
        self.view.addSubview(self.buttonFind)
        self.buttonFind.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-30)
            make.centerX.equalTo(self.view.snp.centerX)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(65)
        }
        
        // Button Login
        self.view.addSubview(self.buttonLogin)
        self.buttonLogin.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.buttonFind.snp.top).offset(-20)
            make.centerX.equalTo(self.view.snp.centerX)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(65)
        }
        
        // Button ViewPortal
        self.view.addSubview(self.buttonViewPortal)
        self.buttonViewPortal.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.buttonFind.snp.top).offset(-20)
            make.centerX.equalTo(self.view.snp.centerX)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(65)
        }
        
        self.view.addSubview(self.viewBackgroundContainer)
        self.viewBackgroundContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(60)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.bottom.equalTo(self.buttonLogin.snp.top).offset(-60)
        }
        // View FoodTruckBackground
        self.viewBackgroundContainer.addSubview(self.viewFoodTruckBackground)
        self.viewFoodTruckBackground.snp.makeConstraints { (make) in
            make.left.equalTo(self.viewBackgroundContainer.snp.left)
            make.right.equalTo(self.viewBackgroundContainer.snp.right)
            make.centerY.equalTo(self.viewBackgroundContainer.snp.centerY)
            make.height.equalTo(UIScreen.main.bounds.size.width - 40)
        }
        
        
        // ImageView FoodTruck
        self.viewFoodTruckBackground.addSubview(self.imageViewFoodTruck)
        self.imageViewFoodTruck.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewFoodTruckBackground.snp.top).offset(15)
            make.left.equalTo(self.viewFoodTruckBackground.snp.left).offset(30)
            make.right.equalTo(self.viewFoodTruckBackground.snp.right).offset(-30)
            make.bottom.equalTo(self.viewFoodTruckBackground.snp.bottom).offset(-15)
        }
    }
    
    // MARK: UIResponders
    @objc private func buttonLogin_TouchUpInside(sender: UIButton) {
        self.navigateToLogin()
    }
    
    @objc private func buttonViewPortal_TouchUpInside(sender: UIButton) {
        self.navigateToDealerPortal()
    }
    
    @objc private func buttonFind_TouchUpInside(sender: UIButton) {
        self.navigateToFindFoodTrucks()
    }
    
    // MARK: Navigation Logic
    private func navigateToFindFoodTrucks() {
        let destinationVC = FindFoodTrucksViewController.init()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    private func navigateToDealerPortal() {
        let destinationVC = DealerPortalViewController.init()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    private func navigateToLogin() {
        let destinationVC = LoginViewController.init()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    // MARK: - Public API
    
    
    
}
