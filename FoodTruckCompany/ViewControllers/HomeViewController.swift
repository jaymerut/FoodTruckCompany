//
//  HomeViewController.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 9/13/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    
    // MARK: - Variables
    
    
    
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
        // Setup
        setupHomeViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Private API
    private func setupHomeViewController() {
        
        // Self
        
        
    }
    
    
    
    // MARK: - Public API
    
    
    
}
