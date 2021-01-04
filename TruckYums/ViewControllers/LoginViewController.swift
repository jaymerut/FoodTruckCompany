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
    private var users: [User] = []
    private var companies: [Company] = []
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.color = .black
        
        return activityIndicator
    }()
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
    
    private lazy var imageViewLogo: UIImageView = {
        let imageView = UIImageView.init(frame: .zero)
        imageView.image = UIImage.init(named: "logo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
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
        button.setTitle("", for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        button.backgroundColor = UIColor.init(hex: "0x055e86")
        button.layer.cornerRadius = 6.0
        button.addTarget(self, action: #selector(buttonLogin_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var labelNavTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Login"
        label.font = UIFont(name: "Teko-Medium", size: 24)
        label.textColor = .white
        
        return label
    }()
    private lazy var labelRegister: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 22.0)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        
        let text = NSMutableAttributedString(string: "New Food Vendor? Register Here")
        text.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: NSRange(location: "New Food Vendor? ".count, length: "Register Here".count))
        text.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hex: 0x09a0e5), range: NSRange(location: "New Food Vendor? ".count, length: "Register Here".count))
        label.attributedText = text
        
        return label
    }()
    
    private lazy var labelForgotPassword: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 20.0)
        label.textAlignment = .center
        label.textColor = .init(hex: 0x09a0e5)
        label.isUserInteractionEnabled = true
        
        let attributes = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let attributedText = NSAttributedString(string: "Forgot Password?", attributes: attributes)
        label.attributedText = attributedText
        
        return label
    }()
    
    private lazy var firebaseCloudRead: FirebaseCloudRead = {
        let firebaseCloudRead = FirebaseCloudRead.init()
        
        return firebaseCloudRead
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
        self.navigationItem.titleView = self.labelNavTitle
        
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
        
        let gestureTapForgotPassword: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(gestureTap_ForgotPassword))
        
        self.labelForgotPassword.addGestureRecognizer(gestureTapForgotPassword)
        
        let gestureTapRegister: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(gestureTap_Register))
        
        self.labelRegister.addGestureRecognizer(gestureTapRegister)
        
        self.view.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.centerY.equalTo(self.view.snp.centerY)
            make.height.equalTo(475)
        }
        
        self.containerView.addSubview(self.labelRegister)
        self.labelRegister.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView.snp.left).offset(20)
            make.right.equalTo(self.containerView.snp.right).offset(-20)
            make.bottom.equalTo(self.containerView.snp.bottom).offset(-20)
            make.height.equalTo(20)
        }
        
        self.containerView.addSubview(self.buttonLogin)
        self.buttonLogin.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView.snp.left).offset(20)
            make.right.equalTo(self.containerView.snp.right).offset(-20)
            make.bottom.equalTo(self.labelRegister.snp.top).offset(-10)
            make.height.equalTo(60)
        }
        
        self.containerView.addSubview(self.labelForgotPassword)
        self.labelForgotPassword.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView.snp.left).offset(20)
            make.right.equalTo(self.containerView.snp.right).offset(-20)
            make.bottom.equalTo(self.buttonLogin.snp.top).offset(-30)
            make.height.equalTo(20)
        }
        
        self.containerView.addSubview(self.textFieldPassword)
        self.textFieldPassword.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView.snp.left).offset(20)
            make.right.equalTo(self.containerView.snp.right).offset(-20)
            make.bottom.equalTo(self.labelForgotPassword.snp.top).offset(-10)
            make.height.equalTo(50)
        }
        
        self.containerView.addSubview(self.textFieldEmail)
        self.textFieldEmail.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView.snp.left).offset(20)
            make.right.equalTo(self.containerView.snp.right).offset(-20)
            make.bottom.equalTo(self.textFieldPassword.snp.top).offset(-10)
            make.height.equalTo(50)
        }
        
        self.textFieldEmail.addSubview(self.activityIndicator)
        self.activityIndicator.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.textFieldEmail.snp.centerY)
            make.right.equalTo(self.textFieldEmail.snp.right).offset(-10)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        self.containerView.addSubview(self.viewImageContainer)
        self.viewImageContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.right)
            make.bottom.equalTo(self.textFieldEmail.snp.top)
        }
        
        self.viewImageContainer.addSubview(self.imageViewLogo)
        self.imageViewLogo.snp.makeConstraints { (make) in
            make.edges.equalTo(self.viewImageContainer)
        }
    }
    
    private func verifyForm() -> Bool {
        if self.textFieldEmail.text?.count == 0 && self.textFieldPassword.text?.count == 0 {
            self.displayMessage(title: "Error", message: "Please enter in an email and password.")
            return false
        } else if self.textFieldEmail.text?.count == 0 {
            self.displayMessage(title: "Error", message: "Please enter in an email")
            return false
        } else if self.textFieldPassword.text?.count == 0 {
            self.displayMessage(title: "Error", message: "Please enter in a password")
            return false
        } else {
            return true
        }
    }
    private func verifyEmail() -> Bool {
        //Create a regex string
        let stricterFilterString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", stricterFilterString)
        
        //return true if email address is valid
        if emailTest.evaluate(with: self.textFieldEmail.text) {
            return true
        } else {
            self.displayMessage(title: "Error", message: "Email is in an invalid format.")
            return false
        }
    }
    private func login() {
        self.firebaseCloudRead.firebaseReadUsers { (users) in
            self.users = users ?? [User]()
            
            if self.doesUserExist() {
                self.navigateToHome()
                
            } else {
                self.displayMessage(title: "Error", message: "Invalid credentials. Please try again. Remember that email is case-sensitive.")
            }
            
            self.hideActivityIndicator()
        }
    }
    private func doesUserExist() -> Bool {
        for user in self.users {
            if user.email == self.textFieldEmail.text && user.password == self.textFieldPassword.text {
                SwiftAppDefaults.shared.user = user
                
                self.firebaseCloudRead.firebaseReadCompanies { (companies) in
                    self.companies = companies ?? [Company]()
                    
                    for company in self.companies {
                        if company.name == user.company {
                            SwiftAppDefaults.shared.company = company
                        }
                    }
                }
                return true
            }
        }
        return false
    }
    
    private func displayMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))

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
    @objc private func buttonLogin_TouchUpInside(sender: UIButton) {
        self.showActivityIndicator()
        if self.verifyForm() {
            if self.verifyEmail() {
                self.login()
            } else {
                self.hideActivityIndicator()
            }
        } else {
            self.hideActivityIndicator()
        }
    }
    
    @objc private func gestureTap_Tap(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    @objc private func gestureTap_ForgotPassword(gesture: UITapGestureRecognizer) {
        self.navigateToForgotPassword()
    }
    @objc private func gestureTap_Register(gesture: UITapGestureRecognizer) {
        self.navigateToRegister()
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
    private func navigateToForgotPassword() {
        let destinationVC = ForgotPasswordViewController.init()
        destinationVC.modalPresentationStyle = .overFullScreen
        destinationVC.modalTransitionStyle = .crossDissolve
        
        self.present(destinationVC, animated: true, completion: nil)
    }
    private func navigateToRegister() {
        let destinationVC = RegisterViewController.init()
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
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
