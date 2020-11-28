//
//  DealerPortalViewController.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/27/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit
import SnapKit


class DealerPortalViewController: UIViewController {
    
    
    // MARK: - Variables
    private lazy var buttonLogout: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Teko-Medium", size: 20.0)
        button.addTarget(self, action: #selector(buttonLogout_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - Initialization
    private func customInitDealerPortalViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitDealerPortalViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitDealerPortalViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitDealerPortalViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Setup
        setupDealerPortalViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Private API
    private func setupDealerPortalViewController() {
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(customView: self.buttonLogout), animated: false)
        
    }
    
    // MARK: UIResponders
    @objc private func buttonLogout_TouchUpInside(sender: UIButton) {
        SwiftAppDefaults.shared.user = nil
        self.navigateToHome()
    }
    
    // MARK: Navigation Logic
    private func navigateToHome() {
        let mainVC = HomeViewController()
        let destinationNC = UINavigationController(rootViewController: mainVC)
        destinationNC.navigationBar.barTintColor = UIColor.init(hex: "0x055e86")
        destinationNC.navigationBar.tintColor = .white
        destinationNC.navigationBar.isTranslucent = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = destinationNC
    }
    
    // MARK: - Public API
    
    
    
}
