//
//  ForgotPasswordViewController.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/31/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - Variables
    private let colorInProgress: UIColor = UIColor.init(hex: "0x3C9ADC")!
    private let colorRequired: UIColor = UIColor.init(hex: "0xDC3C4A")!
    private let colorNotRequired: UIColor = UIColor.init(hex: "0xE8ECF0")!
    private let colorCompleted: UIColor = UIColor.init(hex: "0x3CDC7E")!
    private var users: [User] = []
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.color = .black
        
        return activityIndicator
    }()
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20.0
        
        return view
    }()
    private lazy var viewHeader: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = Constants.mainColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 20.0
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return view
    }()
    
    private lazy var labelHeader: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Forgot Password"
        
        return label
    }()
    private lazy var labelEmail: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 18.0)
        label.text = "Enter Email of Account: *"
        
        return label
    }()
    private lazy var labelName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 18.0)
        label.text = "Enter Name of Account: *"
        
        return label
    }()
    private lazy var labelPassword: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 18.0)
        label.text = "Enter New Password: *"
        
        return label
    }()
    private lazy var labelPasswordRepeat: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 18.0)
        label.text = "Repeat New Password: *"
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    private lazy var textFieldEmail: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 16.0)
        textField.placeholder = "Enter Email"
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        textField.layer.borderColor = self.colorRequired.cgColor
        
        return textField
    }()
    private lazy var textFieldName: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 16.0)
        textField.placeholder = "Enter Name"
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        textField.layer.borderColor = self.colorRequired.cgColor
        
        return textField
    }()
    private lazy var textFieldPassword: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 16.0)
        textField.placeholder = "Enter Password"
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        textField.isSecureTextEntry = true
        textField.layer.borderColor = self.colorRequired.cgColor
        
        return textField
    }()
    private lazy var textFieldPasswordRepeat: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 16.0)
        textField.placeholder = "Enter Password Again"
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.layer.borderColor = self.colorRequired.cgColor
        
        return textField
    }()
    
    private lazy var buttonApply: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Change Password", for: .normal)
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
    
    private lazy var firebaseCloudRead: FirebaseCloudRead = {
        let firebaseCloudRead = FirebaseCloudRead.init()
        
        return firebaseCloudRead
    }()
    private lazy var firebaseCloudUpdate: FirebaseCloudUpdate = {
        let firebaseCloudUpdate = FirebaseCloudUpdate.init()
        
        return firebaseCloudUpdate
    }()
    private var messageHelper: MessageHelper = MessageHelper()
    
    // MARK: - Initialization
    private func customInitForgotPasswordViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitForgotPasswordViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitForgotPasswordViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitForgotPasswordViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(white: 0.0, alpha: 0.6)
        
        // Setup
        setupForgotPasswordViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Private API
    private func setupForgotPasswordViewController() {
        
        // Tap Gesture
        let gestureTap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(gestureTap_Tap))
        gestureTap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(gestureTap)
        
        // Content View
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(self.view.snp.top).offset(100)
            make.left.equalTo(self.view.snp.left).offset(50)
            make.right.equalTo(self.view.snp.right).inset(50)
            make.height.equalTo(0).priority(250)
        }
        
        // View Header
        self.contentView.addSubview(self.viewHeader)
        self.viewHeader.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.height.greaterThanOrEqualTo(50)
        }
        
        // Label Header
        self.viewHeader.addSubview(self.labelHeader)
        self.labelHeader.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewHeader.snp.top).offset(5)
            make.centerX.equalTo(self.viewHeader.snp.centerX)
            make.bottom.equalTo(self.viewHeader.snp.bottom).offset(-5)
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
        
        // Collection View
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewHeader.snp.bottom).offset(20)
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.bottom.equalTo(self.buttonClose.snp.top).offset(-20)
            make.height.equalTo(150)
        }
        
        // Activity Indicator
        self.collectionView.addSubview(self.activityIndicator)
        self.activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.collectionView.snp.centerX)
            make.centerY.equalTo(self.collectionView.snp.centerY)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        // Email
        self.collectionView.addSubview(self.labelEmail)
        self.labelEmail.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView.snp.top)
            make.left.equalTo(self.collectionView.snp.left)
            make.right.equalTo(self.contentView.snp.centerX).offset(-5)
            
        }
        self.collectionView.addSubview(self.textFieldEmail)
        self.textFieldEmail.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelEmail.snp.bottom).offset(5)
            make.left.equalTo(self.collectionView.snp.left)
            make.right.equalTo(self.contentView.snp.centerX).offset(-5)
            make.height.equalTo(40)
        }
        
        // Name
        self.collectionView.addSubview(self.labelName)
        self.labelName.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldEmail.snp.bottom).offset(5)
            make.left.equalTo(self.collectionView.snp.left)
            make.right.equalTo(self.contentView.snp.centerX).offset(-5)
        }
        self.collectionView.addSubview(self.textFieldName)
        self.textFieldName.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelName.snp.bottom).offset(5)
            make.left.equalTo(self.collectionView.snp.left)
            make.right.equalTo(self.contentView.snp.centerX).offset(-5)
            make.height.equalTo(40)
        }
        
        // Password
        self.collectionView.addSubview(self.labelPassword)
        self.labelPassword.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView.snp.top)
            make.left.equalTo(self.contentView.snp.centerX).offset(5)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
        }
        self.collectionView.addSubview(self.textFieldPassword)
        self.textFieldPassword.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelPassword.snp.bottom).offset(5)
            make.left.equalTo(self.contentView.snp.centerX).offset(5)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.height.equalTo(40)
        }
        
        // Password Repeat
        self.collectionView.addSubview(self.labelPasswordRepeat)
        self.labelPasswordRepeat.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldPassword.snp.bottom).offset(5)
            make.left.equalTo(self.contentView.snp.centerX).offset(5)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
        }
        self.collectionView.addSubview(self.textFieldPasswordRepeat)
        self.textFieldPasswordRepeat.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelPasswordRepeat.snp.bottom).offset(5)
            make.left.equalTo(self.contentView.snp.centerX).offset(5)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.height.equalTo(40)
        }
        
    }
    
    private func changePassword() {
        self.showActivityIndicator()
        
        if verifyForm() {
            
            self.firebaseCloudRead.firebaseReadUsers { (users) in
                self.users = users ?? [User]()
                
                if self.doesUserExist() {
                    
                    let modifiedUser: User = User.init()
                    modifiedUser.email = self.textFieldEmail.text ?? ""
                    modifiedUser.password = (self.textFieldPassword.text ?? "").encrypt()
                    
                    self.firebaseCloudUpdate.firebaseUpdateUserPassword(modifiedUser: modifiedUser) { (user) in
                        if user != nil {
                            self.displaySuccess(title: "Success", message: "Password successfully updated!")
                            self.hideActivityIndicator()
                        }
                    }
                } else {
                    self.present(self.messageHelper.displayMessage(title: "Error", message: "Incorrect email or name. Please try again. Remember that email is case-sensitive."), animated: true)
                    self.hideActivityIndicator()
                }
            }
            
        }

    }
    private func doesUserExist() -> Bool {
        for user in self.users {
            if user.email == self.textFieldEmail.text && user.name.lowercased() == self.textFieldName.text?.lowercased() {
                return true
            }
        }
        return false
    }
    
    private func verifyForm() -> Bool {
        if self.textFieldEmail.text?.count == 0 ||
            self.textFieldName.text?.count == 0 ||
            self.textFieldPassword.text?.count == 0 ||
            self.textFieldPasswordRepeat.text?.count == 0 {
            self.present(self.messageHelper.displayMessage(title: "Error", message: "Please enter values in the required fields"), animated: true)
            self.hideActivityIndicator()
            return false
        } else if self.verifyPasswords() {
            return true
        } else {
            self.hideActivityIndicator()
            return false
        }
    }
    
    private func verifyPasswords() -> Bool {
        if self.textFieldPassword.text != self.textFieldPasswordRepeat.text {
            self.present(self.messageHelper.displayMessage(title: "Error", message: "Passwords don't match."), animated: true)
            return false
        }
        
        return true
    }
    
    private func displaySuccess(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))

        self.present(alert, animated: true)
    }
    
    private func showActivityIndicator() {
        self.view.isUserInteractionEnabled = false
        self.activityIndicator.startAnimating()
    }
    private func hideActivityIndicator() {
        self.view.isUserInteractionEnabled = true
        self.activityIndicator.stopAnimating()
    }
    
    // MARK: UIResponders
    @objc private func buttonClose_TouchUpInside(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func buttonApply_TouchUpInside(sender: UIButton) {
        Analytics.logEvent("changepassword_clicked", parameters: nil)
        self.changePassword()
    }
    @objc private func gestureTap_Tap(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // MARK: - Public API
    
    // MARK: Delegate Methods
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = self.colorInProgress.cgColor
        textField.becomeFirstResponder()
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.layer.borderColor = self.colorRequired.cgColor
        } else {
            textField.layer.borderColor = self.colorCompleted.cgColor
        }
        
        textField.resignFirstResponder()
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textFieldEmail {
            self.textFieldName.becomeFirstResponder()
        } else if textField == self.textFieldName {
            self.textFieldPassword.becomeFirstResponder()
        } else if textField == self.textFieldPassword {
            self.textFieldPasswordRepeat.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        
        return true
    }
    
}
