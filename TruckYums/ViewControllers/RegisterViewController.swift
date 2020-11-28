//
//  RegisterViewController.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/26/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController, UITextFieldDelegate  {
    
    
    // MARK: - Variables
    private lazy var containerView: UIView = {
        let view = UIView.init(frame: .zero)
        
        return view
    }()
    
    private lazy var textFieldEmail: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 14.0)
        textField.placeholder = "Enter Email"
        
        return textField
    }()
    private lazy var textFieldName: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 14.0)
        textField.placeholder = "Enter Name"
        
        return textField
    }()
    private lazy var textFieldPassword: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 14.0)
        textField.placeholder = "Enter Password"
        
        return textField
    }()
    private lazy var textFieldPasswordRepeat: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 14.0)
        textField.placeholder = "Enter Password Again"
        
        return textField
    }()
    
    private lazy var buttonSubmit: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        button.backgroundColor = UIColor.init(hex: "0x055e86")
        button.layer.cornerRadius = 32.5
        button.addTarget(self, action: #selector(buttonSubmit_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - Initialization
    private func customInitRegisterViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitRegisterViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitRegisterViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitRegisterViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Setup
        setupRegisterViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Private API
    private func setupRegisterViewController() {
        
        self.view.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
        }
        
        self.containerView.addSubview(self.textFieldName)
        self.textFieldName.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.textFieldEmail)
        self.textFieldEmail.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldName.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.textFieldPassword)
        self.textFieldPassword.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldEmail.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.textFieldPasswordRepeat)
        self.textFieldPasswordRepeat.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldPassword.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.buttonSubmit)
        self.buttonSubmit.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldPasswordRepeat.snp.bottom).offset(20)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(65)
        }
        
        
    }
    
    // MARK: UIResponders
    @objc private func buttonSubmit_TouchUpInside(sender: UIButton) {
        
    }
    
    
    // MARK: - Public API
    
    
    
}
