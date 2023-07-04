//
//  FindFoodTrucksViewController.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 11/26/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation
import GoogleMobileAds


class FindFoodTrucksViewController: UIViewController, ListAdapterDataSource, MKMapViewDelegate, CLLocationManagerDelegate, GADBannerViewDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    
    
    // MARK: - Variables
    public var companies: [String: Company] = [:]
    var bannerView: GADBannerView!
    
    let distanceSpan: Double = 50
    var currentRadius: Double = 0
    var isShowingList: Bool = false
    
    private var vendorLocations: [ListDiffable] = [ListDiffable]()
    
    private lazy var stackViewBannerAds: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        
        return stackView
    }()
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater.init(), viewController: self, workingRangeSize: 0)
        adapter.scrollViewDelegate = self
        
        return adapter
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .white
        collectionView.isHidden = true
        collectionView.backgroundColor = Constants.mainColor
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    private lazy var labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Nearby Food Vendors"
        label.font = UIFont(name: "Teko-Medium", size: 24)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var viewControlContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black
        
        return view
    }()
    private lazy var segmentedControlMiles: UISegmentedControl = {
        let control = UISegmentedControl(items: ["5 miles", "10 miles", "20 miles", "30 miles"])
        control.backgroundColor = UIColor.black
        control.selectedSegmentTintColor = Constants.secondaryColor
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        control.setTitleTextAttributes(titleTextAttributes, for:.normal)
        control.setTitleTextAttributes(titleTextAttributes, for:.selected)
        
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        control.selectedSegmentIndex = 1;
        
        return control
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.color = .black
        
        return activityIndicator
    }()
    
    private let milesToMetersArray: [Double] = [8046.72, 16093.4, 32186.9, 48280.3]
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .white
        textField.delegate = self
        textField.placeholder = "Filter by Name"
        textField.font = UIFont(name: "Teko-Regular", size: 18.0)
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.layer.borderWidth = 1.5
        textField.leftView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        
        return textField
    }()
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView.init(frame: .zero)
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsScale = true
        mapView.showsCompass = false
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        return mapView
    }()
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 5
        
        return manager
    }()
    private lazy var firebaseCloudRead: FirebaseCloudRead = {
        let firebaseCloudRead = FirebaseCloudRead.init()
        
        return firebaseCloudRead
    }()
    private lazy var queryHelper: QueryHelper = {
        let helper = QueryHelper()
        
        return helper
    }()
    private lazy var googlePlacesAPI: GooglePlaceAPI = {
        let api = GooglePlaceAPI()
        
        return api
    }()
    private lazy var dateTimeHelper: DateTimeHelper = {
        let helper = DateTimeHelper()
        
        return helper
    }()
    private lazy var mkPOICategoryHelper: MKPointOfInterestCategoryHelper = {
        let helper = MKPointOfInterestCategoryHelper()
        
        return helper
    }()
    private lazy var googlePlaceHelper: GooglePlaceHelper = {
        let helper = GooglePlaceHelper()
        
        return helper
    }()
    
    // MARK: - Initialization
    private func customInitFindFoodTrucksViewController() {
        
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        customInitFindFoodTrucksViewController()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInitFindFoodTrucksViewController()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        customInitFindFoodTrucksViewController()
    }
    
    
    
    // MARK: - UIViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentRadius = self.milesToMetersArray[self.segmentedControlMiles.selectedSegmentIndex]
        self.view.backgroundColor = .white
        self.navigationItem.titleView = self.labelTitle
        
        self.bannerView = GADBannerView(adSize: GADAdSize.init(size: CGSize.init(width: self.view.frame.size.width ?? 0, height: 160), flags: 1))
        self.bannerView.adUnitID = "ca-app-pub-7088839014127907/5824681329"
        self.bannerView.rootViewController = self
        self.bannerView.delegate = self
        self.bannerView.load(GADRequest())
        
        self.getUserCoordinates()
        
        self.updateRightBarButton()
        
        // Setup
        setupFindFoodTrucksViewController()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    // MARK: - Private API
    private func setupFindFoodTrucksViewController() {
        
        self.view.backgroundColor = Constants.mainColor
        
        // Adapter
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        
        self.view.addSubview(self.stackViewBannerAds)
        self.stackViewBannerAds.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(0).priority(250);
        }
        
        self.view.addSubview(self.viewControlContainer)
        self.viewControlContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.stackViewBannerAds.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
        self.viewControlContainer.addSubview(self.segmentedControlMiles)
        self.segmentedControlMiles.snp.makeConstraints { (make) in
            make.edges.equalTo(self.viewControlContainer)
        }
        
        self.view.addSubview(self.searchTextField)
        self.searchTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewControlContainer.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(self.mapView)
        self.mapView.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchTextField.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchTextField.snp.bottom).offset(5)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
        }
        
    }
    private func updateRightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: self.isShowingList ? "Map" : "List", style: .plain, target: self, action: #selector(toggleList))
    }
    private func getUserCoordinates() {
        self.activityIndicator.startAnimating()
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
    }
    
    private func addCompaniesToMap(companies: [String: Company]) {
        for (key, value) in companies {
            let annotation = MKPointAnnotation()
            annotation.title = key
            annotation.coordinate = CLLocationCoordinate2D(latitude: value.latitude, longitude: value.longitude)
            self.mapView.addAnnotation(annotation)
            
            self.vendorLocations.append(VendorLocation(
                name: value.name,
                weeklyHours: value.weeklyhours
            ))
        }
        
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    // MARK: Navigation Logic
    private func navigateToCompanyDetail(company: String) {
        let destinationVC = CompanyDetailViewController.init()
        destinationVC.modalPresentationStyle = .overFullScreen
        destinationVC.modalTransitionStyle = .crossDissolve
        destinationVC.company = self.companies[company] ?? Company()
        
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    // MARK: UIResponders
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.currentRadius = self.milesToMetersArray[sender.selectedSegmentIndex]
        
        self.companies = [:]
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        self.vendorLocations = [ListDiffable]()
        self.getUserCoordinates()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        self.vendorLocations = [ListDiffable]()

        var filteredArray = [String: Company]()
        
        for (key, value) in self.companies {
            if key.lowercased().contains((textField.text ?? "").lowercased()) {
                filteredArray[key] = value
            }
        }
        
        if (textField.text?.isEmpty == true) {
            filteredArray = self.companies
        }
        
        self.addCompaniesToMap(companies: filteredArray)
    }
    
    @objc func toggleList() {
        self.isShowingList = !self.isShowingList
        self.updateRightBarButton()
        
        self.mapView.isHidden = self.isShowingList
        self.collectionView.isHidden = !self.isShowingList
    }
    
    // MARK: Delegate Methods
    
    // CLLocation Delegate Methods
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        let region = MKCoordinateRegion.init(center: newLocation.coordinate, latitudinalMeters: self.distanceSpan, longitudinalMeters: self.distanceSpan)
        self.mapView.setRegion(region, animated: false)
        self.mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let currentLocation:CLLocation = locations.last ?? CLLocation.init()
        let region = MKCoordinateRegion(
              center: currentLocation.coordinate,
            latitudinalMeters: 50000,
            longitudinalMeters: 60000)

        self.firebaseCloudRead.firebaseReadCompanies { (companies) in
            for company in companies ?? [Company]() {
                self.companies[company.name] = company
            }
            self.googlePlacesAPI.searchNearby("food trucks", latitude: locValue.latitude as NSNumber, longitude: locValue.longitude as NSNumber, radius: self.currentRadius as NSNumber) { (result) in
                var index: Int = 0
                for place in result!.results {
                    self.googlePlacesAPI.getPlaceDetails(place.reference, fields: ["name","formatted_phone_number","geometry","opening_hours","types","website"]) { (detailsResult) in
                        if (detailsResult?.status == "OK" && detailsResult?.result.openingHours?.weekdayText.count ?? 0 > 0) {
                            
                            let convertedCompany = self.googlePlaceHelper.convertGooglePlaceDetailsToCompany(details: detailsResult!)
                            
                            let keyExists = self.companies[convertedCompany.name]
                            if (keyExists == nil && convertedCompany.name.count > 0) {
                                self.companies[convertedCompany.name] = convertedCompany
                            }
                        }
                        
                        if result!.results.count <= index + 1 {
                            self.addCompaniesToMap(companies: self.companies)
                            
                            let mapCamera = MKMapCamera(lookingAtCenter: locValue, fromEyeCoordinate: locValue, eyeAltitude: self.currentRadius)
                            self.mapView.setCamera(mapCamera, animated: true)
                            
                            manager.stopUpdatingLocation()
                            self.activityIndicator.stopAnimating()
                        }
                        index+=1
                    } failure: { (error) in
                        self.activityIndicator.stopAnimating()
                    }
                }
            } failure: { (error) in
                self.activityIndicator.stopAnimating()
            }
        }
        
        
        // Apple Maps Search (Not as good as GooglePlacesAPI for now)
        /*
        self.queryHelper.searchBy(naturalLanguageQuery: "food truck", region: region, coordinates: locValue) { (response, error) in
            
            for mapItem in response?.mapItems ?? [MKMapItem]() {
                let company = Company()
                company.name = mapItem.name ?? ""
                company.phonenumber = mapItem.phoneNumber ?? ""
                company.siteurl = mapItem.url?.absoluteString ?? ""
                company.longitude = mapItem.placemark.coordinate.longitude
                company.latitude = mapItem.placemark.coordinate.latitude
                company.cuisine = self.mkPOICategoryHelper.convertRawValueToStringValue(rawValue: mapItem.pointOfInterestCategory?.rawValue ?? "")
                company.venderverified = false
                company.lastupdated = self.dateTimeHelper.retrieveCurrentDateTime()
                
                let keyExists = self.companies[company.name]
                if (keyExists == nil) {
                    self.companies[company.name] = company
                }
            }
            
            for (key, value) in self.companies {
                let annotation = MKPointAnnotation()
                annotation.title = key
                annotation.coordinate = CLLocationCoordinate2D(latitude: value.latitude, longitude: value.longitude)
                self.mapView.addAnnotation(annotation)
            }
            
            let mapCamera = MKMapCamera(lookingAtCenter: locValue, fromEyeCoordinate: locValue, eyeAltitude: 15000)
            self.mapView.setCamera(mapCamera, animated: true)
            
            manager.stopUpdatingLocation()
        }
 */
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    // MKMapView Delegate Methods
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if (view.annotation?.title ?? "")?.count ?? 0 > 0 && (view.annotation?.title ?? "") != "My Location" {
            self.navigateToCompanyDetail(company: (view.annotation?.title ?? "") ?? "")
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation.title == "My Location") {
            return nil
        }
        let reuseId = "test"

        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }

        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...

        let companyName = (annotation.title ?? "") ?? ""
        let company = self.companies[companyName] ?? Company.init()
        
        if company.venderverified {
            anView?.image = UIImage(named:"image_verified_annotation")
        } else {
            anView?.image = UIImage(named:"image_annotation")
        }
        

        return anView
    }
    
    // ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        self.vendorLocations
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return VendorLocationsSectionController.init()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let label = UILabel(frame: .zero)
        label.text = "No Vendors Found"
        label.textAlignment = .center
        
        return label
    }
    
    // MARK: - Public API
    
    // MARK: Delegate Methods
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        self.bannerView = bannerView
        self.stackViewBannerAds.addArrangedSubview(self.bannerView)
        print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.init(hex: "0x3C9ADC")?.cgColor
        textField.becomeFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.init(hex: "0xE8ECF0")?.cgColor
        textField.resignFirstResponder()
    }
    
}
