//
//  LoginViewController.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/26/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - Variables
    private lazy var containerView: UIView = {
        let view = UIView.init(frame: .zero)
        view.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 20.0
        
        return view
    }()
    private lazy var viewImageContainer: UIView = {
        let view = UIView.init(frame: .zero)
        
        return view
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.font = UIFont.init(name: "KaushanScript-Regular", size: 40.0)
        label.text = "Food Truck Locator"
        label.textAlignment = .center
        label.textColor = UIColor.init(hex: "0x055e86")
        
        return label
    }()
    
    private lazy var textFieldEmail: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "Enter Email"
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        
        return textField
    }()
    private lazy var textFieldPassword: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "Enter Password"
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private lazy var buttonLogin: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        button.backgroundColor = UIColor.init(hex: "0x055e86")
        button.layer.cornerRadius = 6.0
        button.addTarget(self, action: #selector(buttonLogin_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Initialization
    private func customInitLoginViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitLoginViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitLoginViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitLoginViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Setup
        setupLoginViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    // MARK: - Private API
    private func setupLoginViewController() {
        
        // Tap Gesture
        let gestureTap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(gestureTap_Tap))
        gestureTap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(gestureTap)
        
        self.view.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.centerY.equalTo(self.view.snp.centerY)
            make.height.equalTo(325)
        }
        
        self.containerView.addSubview(self.buttonLogin)
        self.buttonLogin.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView.snp.left).offset(20)
            make.right.equalTo(self.containerView.snp.right).offset(-20)
            make.bottom.equalTo(self.containerView.snp.bottom).offset(-20)
            make.height.equalTo(60)
        }
        
        self.containerView.addSubview(self.textFieldPassword)
        self.textFieldPassword.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView.snp.left).offset(20)
            make.right.equalTo(self.containerView.snp.right).offset(-20)
            make.bottom.equalTo(self.buttonLogin.snp.top).offset(-30)
            make.height.equalTo(50)
        }
        
        self.containerView.addSubview(self.textFieldEmail)
        self.textFieldEmail.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView.snp.left).offset(20)
            make.right.equalTo(self.containerView.snp.right).offset(-20)
            make.bottom.equalTo(self.textFieldPassword.snp.top).offset(-10)
            make.height.equalTo(50)
        }
        
        self.containerView.addSubview(self.viewImageContainer)
        self.viewImageContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top).offset(20)
            make.left.equalTo(self.containerView.snp.left).offset(20)
            make.right.equalTo(self.containerView.snp.right).offset(-20)
            make.bottom.equalTo(self.textFieldEmail.snp.top).offset(-20)
        }
        
        self.viewImageContainer.addSubview(self.labelTitle)
        self.labelTitle.snp.makeConstraints { (make) in
            make.edges.equalTo(self.viewImageContainer)
        }
    }
    
    // MARK: UIResponders
    @objc private func buttonLogin_TouchUpInside(sender: UIButton) {
        
    }
    
    @objc private func gestureTap_Tap(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    // MARK: - Public API
    
    // MARK: Delegate Methods
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.init(hex: "0x3C9ADC")?.cgColor
        textField.becomeFirstResponder()
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.resignFirstResponder()
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textFieldEmail {
            self.textFieldPassword.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        
        return true
    }
    
}
