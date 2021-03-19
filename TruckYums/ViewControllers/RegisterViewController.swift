//
//  RegisterViewController.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/26/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController, UITextFieldDelegate, HoursSelectDelegate, SelectCuisineValueDelegate, WeeklyHoursDelegate  {
    
    
    // MARK: - Variables
    private var userApproved: Bool = false
    private var companyApproved: Bool = false
    private var oldPhoneNumberValue: String = ""
    private let colorInProgress: UIColor = UIColor.init(hex: "0x3C9ADC")!
    private let colorRequired: UIColor = UIColor.init(hex: "0xDC3C4A")!
    private let colorNotRequired: UIColor = UIColor.init(hex: "0xE8ECF0")!
    private let colorCompleted: UIColor = UIColor.init(hex: "0x3CDC7E")!
    
    private lazy var containerView: UIView = {
        let view = UIView.init(frame: .zero)
        
        return view
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Registration"
        label.font = UIFont(name: "Teko-Medium", size: 24)
        label.textColor = .white
        
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
        textField.layer.borderColor = self.colorRequired.cgColor
        
        return textField
    }()
    private lazy var textFieldName: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
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
    private lazy var textFieldCompanyName: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "Enter Company Name"
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        textField.layer.borderColor = self.colorRequired.cgColor
        
        return textField
    }()
    private lazy var textFieldPhoneNumber: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "(XXX) XXX-XXXX"
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        textField.keyboardType = .numberPad
        textField.layer.borderColor = self.colorRequired.cgColor
        
        return textField
    }()
    private lazy var textFieldCuisine: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "Enter Cuisine"
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        textField.inputView = UIView.init(frame: .zero)
        textField.addTarget(self, action: #selector(textFieldDidSelect), for: .editingDidBegin)
        textField.layer.borderColor = self.colorRequired.cgColor
        
        return textField
    }()
    private lazy var textFieldHours: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "Enter Weekly Hours"
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        textField.inputView = UIView.init(frame: .zero)
        textField.addTarget(self, action: #selector(textFieldDidSelect), for: .editingDidBegin)
        textField.layer.borderColor = self.colorRequired.cgColor
        
        return textField
    }()
    private lazy var textFieldSiteURL: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "Enter Site Url"
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
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.color = .white
        
        return activityIndicator
    }()
    
    private lazy var buttonSubmit: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Teko-Medium", size: 20.0)
        button.addTarget(self, action: #selector(buttonSubmit_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var hoursArray: [String] = {
        let array = [String]()
        
        return array
    }()
    
    private lazy var firebaseCloudRead: FirebaseCloudRead = {
        let firebaseCloudRead = FirebaseCloudRead.init()
        
        return firebaseCloudRead
    }()
    
    private lazy var firebaseCloudUpdate: FirebaseCloudUpdate = {
        let firebaseCloudUpdate = FirebaseCloudUpdate.init()
        
        return firebaseCloudUpdate
    }()
    
    private lazy var dateTimeHelper: DateTimeHelper = {
        let helper = DateTimeHelper.init()
        
        return helper
    }()
    
    private var messageHelper: MessageHelper = MessageHelper()
    
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
        self.navigationItem.titleView = self.labelTitle
        
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
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(customView: self.buttonSubmit), animated: false)
        
        // Tap Gesture
        let gestureTap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(gestureTap_Tap))
        gestureTap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(gestureTap)
        
        self.view.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(40)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.bottom.equalTo(self.view.snp.bottom).offset(-10)
        }
        
        self.containerView.addSubview(self.textFieldName)
        self.textFieldName.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.centerX).offset(-5)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.textFieldCompanyName)
        self.textFieldCompanyName.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldName.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.centerX).offset(-5)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.textFieldPhoneNumber)
        self.textFieldPhoneNumber.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldCompanyName.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.centerX).offset(-5)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.textFieldCuisine)
        self.textFieldCuisine.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldPhoneNumber.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.centerX).offset(-5)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.textFieldHours)
        self.textFieldHours.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldCuisine.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.right.equalTo(self.containerView.snp.centerX).offset(-5)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.textFieldSiteURL)
        self.textFieldSiteURL.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top)
            make.left.equalTo(self.containerView.snp.centerX).offset(5)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.textFieldEmail)
        self.textFieldEmail.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldSiteURL.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.centerX).offset(5)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.textFieldPassword)
        self.textFieldPassword.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldEmail.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.centerX).offset(5)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(40)
        }
        
        self.containerView.addSubview(self.textFieldPasswordRepeat)
        self.textFieldPasswordRepeat.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldPassword.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.centerX).offset(5)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(40)
        }

    }
    
    private func verifyForm() -> Bool {
        if self.textFieldName.text?.count == 0 ||
            self.textFieldCompanyName.text?.count == 0 ||
            self.textFieldPhoneNumber.text?.count == 0 ||
            self.textFieldCuisine.text?.count == 0 ||
            self.textFieldHours.text?.count == 0 ||
            self.textFieldEmail.text?.count == 0 ||
            self.textFieldPassword.text?.count == 0 ||
            self.textFieldPasswordRepeat.text?.count == 0 {
            self.present(self.messageHelper.displayMessage(title: "Error", message: "Please enter values in the required fields"), animated: true)
            return false
        } else if self.verifyEmail() && self.verifyPhone() && self.verifyPasswords() && self.verifySiteURL() {
            return true
        } else {
            return false
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
            self.present(self.messageHelper.displayMessage(title: "Error", message: "Email is in an invalid format."), animated: true)
            return false
        }
    }
    private func verifyPhone() -> Bool {
        let numString = self.textFieldPhoneNumber.text?.replacingOccurrences(of: "[^\\d+]", with: "", options: [.regularExpression])
        if ((numString?.count ?? 0) == 10) {
            return true
        } else {
            self.present(self.messageHelper.displayMessage(title: "Error", message: "Not enough digits in phone number."), animated: true)
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
    private func verifySiteURL() -> Bool {
        if self.textFieldSiteURL.text?.count ?? 0 > 0 {
            if self.textFieldSiteURL.text?.hasSuffix(".com") ?? false || self.textFieldSiteURL.text?.hasSuffix(".org") ?? false || self.textFieldSiteURL.text?.hasSuffix(".edu") ?? false {
                return true
            } else {
                self.present(self.messageHelper.displayMessage(title: "Error", message: "The site url is in an incorrect format."), animated: true)
                return false
            }
        } else {
            return true
        }
    }
    
    private func displaySuccessMessages() {
        let firstAlert = UIAlertController(title: "Success", message: "Successfully registered!", preferredStyle: .alert)
        firstAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) in
            let secondAlert = UIAlertController(title: "Success", message: "Remember to add your company onto the map by using 'Update With Current Location' through your dealer portal.", preferredStyle: .alert)
            secondAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (alert) in
                self.navigateToHome()
            }))
            
            self.present(secondAlert, animated: true)
        }))
        
        self.present(firstAlert, animated: true)
    }
    
    private func showActivityIndicator() {
        self.view.isUserInteractionEnabled = false
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(customView: self.activityIndicator), animated: false)
        self.activityIndicator.startAnimating()
    }
    private func hideActivityIndicator() {
        self.view.isUserInteractionEnabled = true
        self.activityIndicator.stopAnimating()
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(customView: self.buttonSubmit), animated: false)
    }
    
    private func registerUser() {
        FirebaseCloudRead.init().firebaseReadUsers { (users) in
            self.doesUserExist(users: users ?? [User]())
            if self.userApproved {
                FirebaseCloudRead.init().firebaseReadCompanies { (companies) in
                    self.doesCompanyExist(companies: companies ?? [Company]())
                    if self.companyApproved {
                        let newUser: User = User.init(email: self.textFieldEmail.text!, name: self.textFieldName.text!, password: self.textFieldPassword.text!, phonenumber: self.textFieldPhoneNumber.text!, company: self.textFieldCompanyName.text!)
                        self.firebaseCloudUpdate.firebaseAddUser(newUser: newUser) { (user) in
                            
                            let newCompany: Company = Company.init(name: self.textFieldCompanyName.text!, latitude: 0.0, longitude: 0.0, linkedwith: self.textFieldName.text!, venderverified: true, cuisine: self.textFieldCuisine.text!, phonenumber: self.textFieldPhoneNumber.text!, siteurl: self.textFieldSiteURL.text ?? "", lastupdated: self.dateTimeHelper.retrieveCurrentDateTime(), hours: self.textFieldHours.text!)
                            self.firebaseCloudUpdate.firebaseAddCompany(newCompany: newCompany) { (company) in
                                SwiftAppDefaults.shared.user = user
                                SwiftAppDefaults.shared.company = company
                                
                                self.displaySuccessMessages()
                            }
                            
                        }
                    } else {
                        self.present(self.messageHelper.displayMessage(title: "Error", message: "Company name already exists. Please choose another company name."), animated: true)
                        self.hideActivityIndicator()
                    }
                }
            } else {
                self.present(self.messageHelper.displayMessage(title: "Error", message: "Email already exists. Please choose another email."), animated: true)
                self.hideActivityIndicator()
            }
        }
    }
    
    private func doesUserExist(users: [User]) -> Bool {
        for user in users {
            if user.email.lowercased() == self.textFieldEmail.text?.lowercased() {
                return true
            }
        }
        self.userApproved = true
        return false
    }
    private func doesCompanyExist(companies: [Company]) -> Bool {
        for company in companies {
            if company.name.lowercased() == self.textFieldCompanyName.text?.lowercased() && company.venderverified {
                return true
            }
        }
        self.companyApproved = true
        return false
    }
    
    // MARK: UIResponders
    @objc private func buttonSubmit_TouchUpInside(sender: UIButton) {
        self.showActivityIndicator()
        
        if self.verifyForm() {
            self.registerUser()
        } else {
            self.hideActivityIndicator()
        }
    }
    
    @objc private func gestureTap_Tap(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc private func textFieldDidSelect(sender: UITextField) {
        if sender == self.textFieldCuisine {
            self.navigateToSelectCuisine(cuisine: self.textFieldCuisine.text ?? "")
        } else if sender == self.textFieldHours {
            self.navigateToWeeklyHours(hoursArray: self.hoursArray)
        }
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
    private func navigateToWeeklyHours(hoursArray: [String]) {
        let destinationVC = WeeklyHoursViewController.init()
        destinationVC.modalPresentationStyle = .overFullScreen
        destinationVC.modalTransitionStyle = .crossDissolve
        destinationVC.hoursArray = hoursArray
        destinationVC.delegate = self
        
        self.present(destinationVC, animated: true, completion: nil)
    }
    private func navigateToSelectCuisine(cuisine: String) {
        let destinationVC = SelectCuisineValueViewController.init()
        destinationVC.modalPresentationStyle = .overFullScreen
        destinationVC.modalTransitionStyle = .crossDissolve
        destinationVC.cuisine = cuisine
        destinationVC.delegate = self
        
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    // MARK: - Public API
    
    // MARK: Delegate Methods
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = self.colorInProgress.cgColor
        textField.becomeFirstResponder()
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            if textField == self.textFieldSiteURL {
                textField.layer.borderColor = self.colorNotRequired.cgColor
            } else {
                textField.layer.borderColor = self.colorRequired.cgColor
            }
        } else {
            textField.layer.borderColor = self.colorCompleted.cgColor
        }
        
        textField.resignFirstResponder()
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textFieldName {
            self.textFieldCompanyName.becomeFirstResponder()
        } else if textField == self.textFieldCompanyName {
            self.textFieldPhoneNumber.becomeFirstResponder()
        } else if textField == self.textFieldPhoneNumber {
            self.textFieldCuisine.becomeFirstResponder()
        } else if textField == self.textFieldCuisine {
            self.textFieldHours.becomeFirstResponder()
        } else if textField == self.textFieldHours {
            self.textFieldSiteURL.becomeFirstResponder()
        } else if textField == self.textFieldSiteURL {
            self.textFieldEmail.becomeFirstResponder()
        } else if textField == self.textFieldEmail {
            self.textFieldPassword.becomeFirstResponder()
        } else if textField == self.textFieldPassword {
            self.textFieldPasswordRepeat.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        
        return true
    }
    public func textFieldDidChangeSelection(_ textField: UITextField) {

        if textField == self.textFieldPhoneNumber && self.oldPhoneNumberValue.count < self.textFieldPhoneNumber.text?.count ?? 0 {
            let numString = textField.text?.replacingOccurrences(of: "[^\\d+]", with: "", options: [.regularExpression])
            if (numString?.count == 1) {
                self.textFieldPhoneNumber.text = "(\(numString ?? "")"
            } else if (numString?.count == 3) {
                self.textFieldPhoneNumber.text = "(\(numString ?? "")) "
            } else if (numString?.count == 6) {
                let firstSubString = numString?.substring(with: 0..<3)
                let secondSubstring = numString?.substring(with: 3..<6)
                self.textFieldPhoneNumber.text = "(\(firstSubString ?? "")) \(secondSubstring ?? "")-"
            }
        }
        
        self.oldPhoneNumberValue = self.textFieldPhoneNumber.text ?? ""
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == self.textFieldPhoneNumber && string != "") {
            let numString = textField.text?.replacingOccurrences(of: "[^\\d+]", with: "", options: [.regularExpression])
            if ((numString?.count ?? 0) + 1 > 10) {
                return false
            }
        }
        return true
    }
    
    func updateHours(hoursArray: [String]) {
        self.hoursArray = hoursArray;
        self.textFieldHours.text = "Weekly Hours Set"
        self.textFieldHours.resignFirstResponder()
    }
    func closedHours() {
        self.textFieldHours.resignFirstResponder()
    }
    
    func updateCuisine(cuisine: String) {
        self.textFieldCuisine.text = cuisine
        self.textFieldCuisine.resignFirstResponder()
    }
    func closedCuisine() {
        self.textFieldCuisine.resignFirstResponder()
    }
    
    
}
