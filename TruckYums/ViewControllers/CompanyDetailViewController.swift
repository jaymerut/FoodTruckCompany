//
//  CompanyDetailViewController.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/10/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit
import WebKit
import MapKit
import SafariServices

class CompanyDetailViewController: UIViewController {
    
    
    // MARK: - Variables
    public var company: Company = Company.init(name: "", latitude: 0, longitude: 0, linkedwith: "", venderverified: false, cuisine: "", phonenumber: "", siteurl: "", lastupdated: "", hours: "", weeklyhours: [String]())
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20.0
        
        return view
    }()
    private lazy var viewHeader: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.init(hex: "0x055e86")
        view.clipsToBounds = true
        view.layer.cornerRadius = 20.0
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return view
    }()

    private lazy var viewInfoContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        
        return view
    }()
    private lazy var viewLinkContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    private lazy var imageViewOpenClosed: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var labelHeader: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Medium", size: 24.0)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    private lazy var labelHours: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 22.0)
        label.text = "Hours: "
        
        return label
    }()
    private lazy var labelHoursValue: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Light", size: 20.0)
        
        return label
    }()
    private lazy var labelCuisine: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 22.0)
        label.text = "Cuisine: "
        
        return label
    }()
    private lazy var labelCuisineValue: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Light", size: 20.0)
        
        return label
    }()
    private lazy var labelVerified: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 22.0)
        label.text = "Verified "
        
        return label
    }()
    private lazy var labelLastUpdated: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Light", size: 20.0)
        label.textAlignment = .center
        
        return label
    }()
    
    
    private lazy var buttonMoreHours: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Light", size: 20.0)
        
        let text = NSMutableAttributedString(string: "View Hours")
        text.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: NSRange(location: 0, length: "View Hours".count))
        text.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hex: 0x055e86), range: NSRange(location: 0, length: "View Hours".count))
        
        button.setAttributedTitle(text, for: .normal)
        button.addTarget(self, action: #selector(buttonMoreHours_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    private lazy var buttonPhoneNumber: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "image_call"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Regular", size: 16.0)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        button.setTitle(self.company.phonenumber, for: .normal)
        button.addTarget(self, action: #selector(buttonPhoneNumber_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    private lazy var buttonDirections: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "image_directions"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Regular", size: 18.0)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        button.setTitle("Get Directions", for: .normal)
        button.addTarget(self, action: #selector(buttonDirections_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    private lazy var buttonSite: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "image_site"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Regular", size: 18.0)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        button.setTitle("View Site", for: .normal)
        button.addTarget(self, action: #selector(buttonSite_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    private lazy var imageViewVerified: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .white
        
        return collectionView
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
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return button
    }()
    
    private lazy var dateTimeHelper: DateTimeHelper = {
        let helper = DateTimeHelper.init()
        
        return helper
    }()
    
    // MARK: - Initialization
    private func customInitCompanyDetailViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitCompanyDetailViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitCompanyDetailViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitCompanyDetailViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(white: 0.0, alpha: 0.6)
        
        // Setup
        setupCompanyDetailViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Private API
    private func setupCompanyDetailViewController() {
        
        // Content View
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX);
            make.centerY.equalTo(self.view.snp.centerY);
            make.left.equalTo(self.view.snp.left).offset(50);
            make.right.equalTo(self.view.snp.right).inset(50);
            make.height.equalTo(0).priority(250);
        }
        
        // View Header
        self.contentView.addSubview(self.viewHeader)
        self.viewHeader.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.height.greaterThanOrEqualTo(50)
        }
        
        // ImageView OpenClosed
        self.viewHeader.addSubview(self.imageViewOpenClosed)
        self.imageViewOpenClosed.snp.makeConstraints { (make) in
            make.right.equalTo(self.viewHeader.snp.right).offset(-10)
            make.centerY.equalTo(self.viewHeader.snp.centerY)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
        
        // Label Header
        self.viewHeader.addSubview(self.labelHeader)
        self.labelHeader.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewHeader.snp.top).offset(5)
            make.left.equalTo(self.viewHeader.snp.left).offset(50)
            make.right.equalTo(self.imageViewOpenClosed.snp.left).offset(-5)
            make.bottom.equalTo(self.viewHeader.snp.bottom).offset(-5)
        }
        
        // Close Button
        self.contentView.addSubview(self.buttonClose)
        self.buttonClose.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(50)
        }
        
        // Collection View
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewHeader.snp.bottom).offset(20)
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.bottom.equalTo(self.buttonClose.snp.top)
            make.height.equalTo(140)
        }
        
        // View Info Container
        self.collectionView.addSubview(self.viewInfoContainer)
        self.viewInfoContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView.snp.top)
            make.left.equalTo(self.collectionView.snp.left)
            make.height.equalTo(100)
            make.width.equalTo(175)
        }
        
        // Label Hours
        self.viewInfoContainer.addSubview(self.labelHours)
        self.labelHours.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewInfoContainer.snp.top).offset(4)
            make.left.equalTo(self.viewInfoContainer.snp.left)
            make.height.equalTo(20)
        }
        
        // Button More Hours
        self.viewInfoContainer.addSubview(self.buttonMoreHours)
        self.buttonMoreHours.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewInfoContainer.snp.top).offset(4)
            make.left.equalTo(self.labelHours.snp.right)
            make.centerY.equalTo(self.labelHours.snp.centerY)
        }
        
        // Label Cuisine
        self.viewInfoContainer.addSubview(self.labelCuisine)
        self.labelCuisine.snp.makeConstraints { (make) in
            make.top.equalTo(self.buttonMoreHours.snp.bottom).offset(11)
            make.left.equalTo(self.viewInfoContainer.snp.left)
            make.height.equalTo(20)
        }
        
        // Label Cuisine Value
        self.viewInfoContainer.addSubview(self.labelCuisineValue)
        self.labelCuisineValue.snp.makeConstraints { (make) in
            make.top.equalTo(self.buttonMoreHours.snp.bottom).offset(11)
            make.left.equalTo(self.labelCuisine.snp.right)
            make.centerY.equalTo(self.labelCuisine.snp.centerY)
        }
 
        // Label Verified
        self.viewInfoContainer.addSubview(self.labelVerified)
        self.labelVerified.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelCuisine.snp.bottom).offset(11)
            make.left.equalTo(self.viewInfoContainer.snp.left)
        }
        
        // ImageView Verified
        self.viewInfoContainer.addSubview(self.imageViewVerified)
        self.imageViewVerified.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelCuisine.snp.bottom).offset(11)
            make.left.equalTo(self.labelVerified.snp.right)
            make.centerY.equalTo(self.labelVerified.snp.centerY)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        // View Link Container
        self.collectionView.addSubview(self.viewLinkContainer)
        self.viewLinkContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView.snp.top)
            make.left.equalTo(self.viewInfoContainer.snp.right).offset(5)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        // Button PhoneNumber
        self.viewLinkContainer.addSubview(self.buttonPhoneNumber)
        self.buttonPhoneNumber.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewLinkContainer.snp.top)
            make.left.equalTo(self.viewLinkContainer.snp.left)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        self.buttonPhoneNumber.imageView!.snp.makeConstraints { (make) in
            make.left.equalTo(self.buttonPhoneNumber.snp.left)
            make.centerY.equalTo(self.buttonPhoneNumber.snp.centerY)
        }
        self.buttonPhoneNumber.titleLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(self.buttonPhoneNumber.imageView!.snp.right).offset(5)
            make.centerY.equalTo(self.buttonPhoneNumber.snp.centerY)
        }
        
        // Button Directions
        self.viewLinkContainer.addSubview(self.buttonDirections)
        self.buttonDirections.snp.makeConstraints { (make) in
            make.top.equalTo(self.buttonPhoneNumber.snp.bottom)
            make.left.equalTo(self.viewLinkContainer.snp.left)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        self.buttonDirections.imageView!.snp.makeConstraints { (make) in
            make.left.equalTo(self.buttonDirections.snp.left)
            make.centerY.equalTo(self.buttonDirections.snp.centerY)
        }
        self.buttonDirections.titleLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(self.buttonDirections.imageView!.snp.right).offset(5)
            make.centerY.equalTo(self.buttonDirections.snp.centerY)
        }
        
        // Button Site
        self.viewLinkContainer.addSubview(self.buttonSite)
        self.buttonSite.snp.makeConstraints { (make) in
            make.top.equalTo(self.buttonDirections.snp.bottom)
            make.left.equalTo(self.viewLinkContainer.snp.left)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        self.buttonSite.imageView!.snp.makeConstraints { (make) in
            make.left.equalTo(self.buttonSite.snp.left)
            make.centerY.equalTo(self.buttonSite.snp.centerY)
        }
        self.buttonSite.titleLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(self.buttonSite.imageView!.snp.right).offset(5)
            make.centerY.equalTo(self.buttonSite.snp.centerY)
        }
        
        // Label Last Updated
        self.collectionView.addSubview(labelLastUpdated)
        self.labelLastUpdated.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.collectionView.snp.centerX)
            make.left.equalTo(self.collectionView.snp.left)
            make.right.equalTo(self.collectionView.snp.right)
            make.bottom.equalTo(self.buttonClose.snp.top).offset(-10)
        }
        
        self.updateValues()
    }
    private func updateValues() {
        self.labelHeader.text = self.company.name
        self.labelHoursValue.text = self.company.hours.count > 0 ? self.company.hours : "Call For Hours"
        self.labelCuisineValue.text = self.company.cuisine
        self.labelLastUpdated.text = "Last Updated: \(self.company.lastupdated)"
        
        self.labelCuisine.isHidden = self.company.cuisine.count == 0
        self.labelCuisineValue.isHidden = self.company.cuisine.count == 0
        if self.company.venderverified {
            self.imageViewVerified.image = UIImage(named: "image_vender_verified")
        } else {
            self.imageViewVerified.image = UIImage(named: "image_vender_unverified")
        }
        
        if self.company.siteurl.count == 0 {
            self.buttonSite.isHidden = true
        }
        
        self.buttonPhoneNumber.isHidden = self.company.phonenumber.count == 0
        
        self.imageViewOpenClosed.image = self.retrieveOpenClosedImage()
    }
    private func retrieveOpenClosedImage() -> UIImage {
        if (self.dateTimeHelper.isHoursOpen(hours: self.company.hours)) {
            return UIImage(named: "image_open_sign")!
        } else {
            return UIImage(named: "image_closed_sign")!
        }
    }
    
    // MARK: Navigation Logic
    private func navigateToWebView(urlString: String) {
        var url: URL
        if urlString.hasPrefix("http://") || urlString.hasPrefix("https://") {
            url = URL(string: urlString)!
        } else {
            url = URL(string: "https://\(urlString)")!
        }
        let webView: SFSafariViewController = SFSafariViewController.init(url: url)
        webView.preferredBarTintColor = UIColor.init(hex: "0x055e86")
        webView.preferredControlTintColor = .white
        self.present(webView, animated: true, completion: nil)
    }
    private func navigateToMapsAppWithDirections(to coordinate: CLLocationCoordinate2D, destinationName name: String) {
      let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
      let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = name
      mapItem.openInMaps(launchOptions: options)
    }
    private func navigateToCompanyDetail() {
        let destinationVC = MoreHoursViewController.init()
        destinationVC.modalPresentationStyle = .overFullScreen
        destinationVC.modalTransitionStyle = .crossDissolve
        destinationVC.hoursArray = self.company.weeklyhours
        destinationVC.isVerifiedVendor = self.company.venderverified
        
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    // MARK: UIResponders
    @objc private func buttonMoreHours_TouchUpInside(sender: UIButton) {
        self.navigateToCompanyDetail()
    }
    @objc private func buttonPhoneNumber_TouchUpInside(sender: UIButton) {
        if let url = URL(string: "tel://\(self.company.phonenumber.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @objc private func buttonDirections_TouchUpInside(sender: UIButton) {
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: self.company.latitude, longitude: self.company.longitude)
        self.navigateToMapsAppWithDirections(to: coordinate, destinationName: self.company.name)
    }
    @objc private func buttonSite_TouchUpInside(sender: UIButton) {
        self.navigateToWebView(urlString: self.company.siteurl)
    }
    @objc private func buttonClose_TouchUpInside(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Public API
    
    
    
}
