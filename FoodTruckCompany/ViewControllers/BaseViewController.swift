//
//  BaseViewController.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/25/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit


class BaseViewController: UITabBarController {
    
    
    // MARK: - Variables
    
    
    
    // MARK: - Initialization
    private func customInitBaseViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitBaseViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitBaseViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitBaseViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup
        setupBaseViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Private API
    private func setupBaseViewController() {
        
        // Self
        
        
    }
    
    
    
    // MARK: - Public API
    
    
    
}
