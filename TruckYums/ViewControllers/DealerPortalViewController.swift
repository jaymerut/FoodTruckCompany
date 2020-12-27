//
//  DealerPortalViewController.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/27/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation


class DealerPortalViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    
    // MARK: - Variables
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    private var oldPhoneNumberValue: String = ""
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.color = .white
        
        return activityIndicator
    }()
    private lazy var buttonLogout: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Teko-Medium", size: 20.0)
        button.addTarget(self, action: #selector(buttonLogout_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    private lazy var buttonUpdate: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        button.backgroundColor = UIColor.init(hex: "0x055e86")
        button.layer.cornerRadius = 32.5
        button.addTarget(self, action: #selector(buttonUpdate_TouchUpInside), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    private lazy var buttonChangeLocation: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Update With Current Location", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        button.backgroundColor = UIColor.init(hex: "0xACC649")
        button.layer.cornerRadius = 32.5
        button.addTarget(self, action: #selector(buttonChangeLocation_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    
    private lazy var labelName: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 24.0)
        label.text = "Name: "
        
        return label
    }()
    private lazy var textFieldName: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "Enter Name"
        textField.text = SwiftAppDefaults.shared.user?.name
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        return textField
    }()
    private lazy var labelCompanyName: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 24.0)
        label.text = "Company Name: "
        
        return label
    }()
    private lazy var textFieldCompanyName: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "Company Name"
        textField.text = SwiftAppDefaults.shared.user?.company
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.isEnabled = false
        
        return textField
    }()
    private lazy var labelEmail: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 24.0)
        label.text = "Email: "
        
        return label
    }()
    private lazy var textFieldEmail: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "Email"
        textField.text = SwiftAppDefaults.shared.user?.email
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.isEnabled = false
        
        return textField
    }()
    private lazy var labelPhoneNumber: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 24.0)
        label.text = "Phone Number: "
        
        return label
    }()
    private lazy var textFieldPhoneNumber: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "(XXX) XXX-XXXX"
        textField.text = SwiftAppDefaults.shared.user?.phonenumber
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.keyboardType = .numberPad
        textField.returnKeyType = .next
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        return textField
    }()
    private lazy var labelCuisine: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 24.0)
        label.text = "Cuisine: "
        
        return label
    }()
    private lazy var textFieldCuisine: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "Enter Cuisine"
        textField.text = SwiftAppDefaults.shared.company?.cuisine
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        textField.addTarget(self, action: #selector(textFieldDidSelect), for: .editingDidBegin)
        
        return textField
    }()
    private lazy var labelHours: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 24.0)
        label.text = "Hours: "
        
        return label
    }()
    private lazy var textFieldHours: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.placeholder = "Enter Hours"
        textField.text = SwiftAppDefaults.shared.company?.hours
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6.0
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.returnKeyType = .next
        textField.addTarget(self, action: #selector(textFieldDidSelect), for: .editingDidBegin)
        
        return textField
    }()
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 5
        
        return manager
    }()
    
    private lazy var firebaseCloudUpdate: FirebaseCloudUpdate = {
        let firebaseCloudUpdate = FirebaseCloudUpdate.init()
        
        return firebaseCloudUpdate
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
        self.getUserCoordinates()
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
        
        // Tap Gesture
        let gestureTap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(gestureTap_Tap))
        gestureTap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(gestureTap)
        
        // Update Current Location
        self.view.addSubview(self.buttonChangeLocation)
        self.buttonChangeLocation.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(15)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.bottom.equalTo(self.view.snp.bottom).offset(-15)
            make.height.equalTo(65)
        }
        
        // Update
        self.view.addSubview(self.buttonUpdate)
        self.buttonUpdate.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(15)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.bottom.equalTo(self.buttonChangeLocation.snp.top).offset(-15)
            make.height.equalTo(65)
        }
        
        // ContainerView
        self.view.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(20)
            make.left.equalTo(self.view.snp.left).offset(15)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.bottom.equalTo(self.buttonUpdate.snp.top).offset(-15)
        }
        
        
        
        // Name
        self.containerView.addSubview(self.labelName)
        self.labelName.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top)
            make.left.equalTo(self.containerView.snp.left)
            make.height.equalTo(30)
        }
        self.containerView.addSubview(self.textFieldName)
        self.textFieldName.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top)
            make.left.equalTo(self.labelName.snp.right)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(30)
        }
        
        // Company Name
        self.containerView.addSubview(self.labelCompanyName)
        self.labelCompanyName.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelName.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.height.equalTo(30)
        }
        self.containerView.addSubview(self.textFieldCompanyName)
        self.textFieldCompanyName.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldName.snp.bottom).offset(10)
            make.left.equalTo(self.labelCompanyName.snp.right)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(30)
        }
        
        // Email
        self.containerView.addSubview(self.labelEmail)
        self.labelEmail.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelCompanyName.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.height.equalTo(30)
        }
        self.containerView.addSubview(self.textFieldEmail)
        self.textFieldEmail.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldCompanyName.snp.bottom).offset(10)
            make.left.equalTo(self.labelEmail.snp.right)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(30)
        }
        
        // Phone Number
        self.containerView.addSubview(self.labelPhoneNumber)
        self.labelPhoneNumber.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelEmail.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.height.equalTo(30)
        }
        self.containerView.addSubview(self.textFieldPhoneNumber)
        self.textFieldPhoneNumber.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldEmail.snp.bottom).offset(10)
            make.left.equalTo(self.labelPhoneNumber.snp.right)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(30)
        }
        
        // Cuisine
        self.containerView.addSubview(self.labelCuisine)
        self.labelCuisine.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelPhoneNumber.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.height.equalTo(30)
        }
        self.containerView.addSubview(self.textFieldCuisine)
        self.textFieldCuisine.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldPhoneNumber.snp.bottom).offset(10)
            make.left.equalTo(self.labelCuisine.snp.right)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(30)
        }
        
        // Hours
        self.containerView.addSubview(self.labelHours)
        self.labelHours.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelCuisine.snp.bottom).offset(10)
            make.left.equalTo(self.containerView.snp.left)
            make.height.equalTo(30)
        }
        self.containerView.addSubview(self.textFieldHours)
        self.textFieldHours.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldCuisine.snp.bottom).offset(10)
            make.left.equalTo(self.labelHours.snp.right)
            make.right.equalTo(self.containerView.snp.right)
            make.height.equalTo(30)
        }
        
    }
    private func getUserCoordinates() {
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
    }
    private func showActivityIndicator() {
        self.view.isUserInteractionEnabled = false
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(customView: self.activityIndicator), animated: false)
        self.activityIndicator.startAnimating()
    }
    private func hideActivityIndicator() {
        self.view.isUserInteractionEnabled = true
        self.activityIndicator.stopAnimating()
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(customView: self.buttonLogout), animated: false)
    }
    private func retrieveCurrentDateTime() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    // MARK: UIResponders
    @objc private func buttonLogout_TouchUpInside(sender: UIButton) {
        SwiftAppDefaults.shared.user = nil
        self.navigateToHome()
    }
    @objc private func buttonUpdate_TouchUpInside(sender: UIButton) {
        self.showActivityIndicator()
        
        let modifiedUser: User = User.init()
        modifiedUser.email = self.textFieldEmail.text ?? ""
        modifiedUser.name = self.textFieldName.text ?? ""
        modifiedUser.phonenumber = self.textFieldPhoneNumber.text ?? ""
        modifiedUser.company = SwiftAppDefaults.shared.user?.company ?? ""
        
        self.firebaseCloudUpdate.firebaseUpdateUser(modifiedUser: modifiedUser) { (user) in
            if user != nil {
                SwiftAppDefaults.shared.user = user
            }
            
            let modifiedCompany: Company = Company.init()
            modifiedCompany.name = self.textFieldCompanyName.text ?? ""
            modifiedCompany.phonenumber = self.textFieldPhoneNumber.text ?? ""
            modifiedCompany.lastupdated = self.retrieveCurrentDateTime()
            
            self.firebaseCloudUpdate.firebaseUpdateCompany(modifiedCompany: modifiedCompany) { (company) in
                if company != nil {
                    SwiftAppDefaults.shared.company = company
                }
                
                self.hideActivityIndicator()
                self.buttonUpdate.isHidden = true
            }
        }
        
    }
    @objc private func buttonChangeLocation_TouchUpInside(sender: UIButton) {
        self.showActivityIndicator()
        
        self.firebaseCloudUpdate.firebaseUpdateLocation(company: SwiftAppDefaults.shared.user?.company ?? "", latitude: self.latitude, longitude: self.longitude) {
            
            self.hideActivityIndicator()
        }
    }
    @objc private func textFieldDidChange(sender: UITextField) {
        self.buttonUpdate.isHidden = false
    }
    @objc private func textFieldDidSelect(sender: UITextField) {
        if sender == self.textFieldCuisine {

        } else if sender == self.textFieldHours {

        }
        self.buttonUpdate.isHidden = false
    }
    @objc private func gestureTap_Tap(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
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
        if textField == self.textFieldName {
            self.textFieldPhoneNumber.becomeFirstResponder()
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let currentLocation:CLLocation = locations.last ?? CLLocation.init()
        self.latitude = currentLocation.coordinate.latitude
        self.longitude = currentLocation.coordinate.longitude
        
        setupDealerPortalViewController()
        
        manager.stopUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse {
            manager.startUpdatingLocation()
        } else if status == CLAuthorizationStatus.denied {
            self.buttonChangeLocation.isHidden = true
            setupDealerPortalViewController()
        }
    }
    
}
