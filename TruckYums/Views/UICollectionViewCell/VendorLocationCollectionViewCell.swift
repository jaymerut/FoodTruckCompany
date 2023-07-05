//
//  VendorLocationCollectionViewCell.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 7/4/23.
//  Copyright © 2023 truckyums. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation
import MapKit
import FirebaseAnalytics

class VendorLocationCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Variables
    public var navigateToWebView: ((String) -> ())?
    
    private var model = VendorLocation()
    
    private lazy var dateTimeHelper: DateTimeHelper = {
        let helper = DateTimeHelper.init()
        
        return helper
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var labelName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 24.0)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.showsExpansionTextWhenTruncated = true
        
        return label
    }()
    
    private lazy var labelCuisine: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 20.0)
        label.text = "Cuisine: "
        
        return label
    }()
    private lazy var labelCuisineValue: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Light", size: 20.0)
        
        return label
    }()
    
    private lazy var labelHours: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 20.0)
        label.text = "Hours: "
        
        return label
    }()
    private lazy var labelHoursValue: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Light", size: 20.0)
        
        return label
    }()
    
    private lazy var imageViewOpenClosed: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return imageView
    }()
    
    private lazy var stackViewButtons: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var buttonPhoneNumber: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "image_call"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Regular", size: 16.0)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(buttonPhoneNumber_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        
        return button
    }()
    private lazy var buttonDirections: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "image_directions"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Regular", size: 16.0)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        button.setTitle("Get Directions", for: .normal)
        button.addTarget(self, action: #selector(buttonDirections_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        
        return button
    }()
    private lazy var buttonSite: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "image_site"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = UIFont.init(name: "Teko-Regular", size: 16.0)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        button.setTitle("View Site", for: .normal)
        button.addTarget(self, action: #selector(buttonSite_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    private lazy var labelDistance: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.init(name: "Teko-Regular", size: 18.0)
        
        return label
    }()
    
    // MARK: - Initialization
    private func customInitVendorLocationCollectionViewCell() {
        
        // Setup
        setupVendorLocationCollectionViewCell()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitVendorLocationCollectionViewCell()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customInitVendorLocationCollectionViewCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.stackViewButtons.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        self.containerView.layer.sublayers?.forEach({ layer in
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        })
    }
    
    
    // MARK: - Private API
    private func setupVendorLocationCollectionViewCell() {
        
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(5)
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
        }
        
        self.containerView.addSubview(self.imageViewOpenClosed)
        self.imageViewOpenClosed.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top).offset(10)
            make.right.equalTo(self.containerView.snp.right).offset(-10)
        }
        
        self.containerView.addSubview(self.labelDistance)
        self.labelDistance.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageViewOpenClosed.snp.bottom).offset(5)
            make.right.equalTo(self.containerView.snp.right).offset(-10)
        }
        
        self.containerView.addSubview(self.labelName)
        self.labelName.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top).offset(10)
            make.left.equalTo(self.containerView.snp.left).offset(10)
            make.right.equalTo(self.imageViewOpenClosed.snp.left).offset(-5)
        }
        
        self.containerView.addSubview(self.labelCuisine)
        self.labelCuisine.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelName.snp.bottom)
            make.left.equalTo(self.containerView.snp.left).offset(10)
        }
        self.containerView.addSubview(self.labelCuisineValue)
        self.labelCuisineValue.snp.makeConstraints { (make) in
            make.left.equalTo(self.labelCuisine.snp.right)
            make.centerY.equalTo(self.labelCuisine.snp.centerY)
        }
        
        self.containerView.addSubview(self.labelHours)
        self.labelHours.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelCuisine.snp.bottom)
            make.left.equalTo(self.containerView.snp.left).offset(10)
        }
        self.containerView.addSubview(self.labelHoursValue)
        self.labelHoursValue.snp.makeConstraints { (make) in
            make.left.equalTo(self.labelHours.snp.right)
            make.centerY.equalTo(self.labelHours.snp.centerY)
        }
        
        self.containerView.addSubview(self.stackViewButtons)
        self.stackViewButtons.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelHours.snp.bottom).offset(3)
            make.left.equalTo(self.containerView.snp.left).offset(10)
            make.right.equalTo(self.containerView.snp.right).offset(-10)
            make.height.equalTo(40)
        }
    }
    
    @objc private func buttonPhoneNumber_TouchUpInside(sender: UIButton) {
        Analytics.logEvent("phone_clicked", parameters: nil)
        if let url = URL(string: "tel://\((sender.titleLabel?.text ?? "").addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func buttonDirections_TouchUpInside(sender: UIButton) {
        Analytics.logEvent("directions_clicked", parameters: nil)
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: self.model.latitude, longitude: self.model.longitude)
        self.navigateToMapsAppWithDirections(to: coordinate, destinationName: self.model.name)
    }
    @objc private func buttonSite_TouchUpInside(sender: UIButton) {
        Analytics.logEvent("site_clicked", parameters: nil)
        self.navigateToWebView?(self.model.siteUrl)
    }
    
    private func navigateToMapsAppWithDirections(to coordinate: CLLocationCoordinate2D, destinationName name: String) {
      let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
      let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = name
      mapItem.openInMaps(launchOptions: options)
    }
    
    // MARK: - Public API
    public func update(_ model: VendorLocation) {
        self.model = model
        
        self.labelName.text = model.name
        self.imageViewOpenClosed.image = self.retrieveOpenClosedImage(weeklyHours: model.weeklyHours)
        self.labelCuisineValue.text = model.cuisine
        self.labelHoursValue.text = model.hours.count > 0 ? model.hours : "Call For Hours"
        self.buttonPhoneNumber.setTitle(model.phoneNumber, for: .normal)
        self.labelDistance.text = "\(model.distance.withCommas()) miles away"
        if (!model.phoneNumber.isEmpty) {
            self.stackViewButtons.addArrangedSubview(self.buttonPhoneNumber)
        }
        self.stackViewButtons.addArrangedSubview(self.buttonDirections)
        if (!model.siteUrl.isEmpty) {
            self.stackViewButtons.addArrangedSubview(self.buttonSite)
        }
        
        self.containerView.layer.borderColor = UIColor.init(hex: 0x444444).cgColor
        self.containerView.layer.borderWidth = 1
    }
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [
            UIColor.init(hex: 0xffff00).cgColor,
            UIColor.init(hex: 0xFA8072).cgColor,
            UIColor.init(hex: 0xb6dde8).cgColor,
        ]
        gradientLayer.startPoint = CGPoint(x:0.5, y:0)
        gradientLayer.endPoint = CGPoint(x:1, y:1)
        gradientLayer.frame = self.containerView.bounds
                
        self.containerView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func retrieveOpenClosedImage(weeklyHours: [String]) -> UIImage {
        let index = self.dateTimeHelper.retrieveCurrentWeekDayIndex()
        let hours = weeklyHours[index]
        if (self.dateTimeHelper.isHoursOpen(hours: hours)) {
            return UIImage(named: "image_open_sign")!
        } else {
            return UIImage(named: "image_closed_sign")!
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        
        if (self.model.isVerified) {
            self.setGradientBackground()
        }
        
        return layoutAttributes
    }
}
