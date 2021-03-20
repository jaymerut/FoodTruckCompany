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


class FindFoodTrucksViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, GADBannerViewDelegate {
    
    
    // MARK: - Variables
    public var companies: [String: Company] = [:]
    var bannerView: GADBannerView!
    
    let distanceSpan: Double = 50
    var currentRadius: Double = 0
    
    private lazy var stackViewBannerAds: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        
        return stackView
    }()
    private lazy var labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Nearby Food Venders"
        label.font = UIFont(name: "Teko-Medium", size: 24)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var segmentedControlMiles: UISegmentedControl = {
        let control = UISegmentedControl(items: ["10 miles", "25 miles", "50 miles", "100 miles"])
        control.backgroundColor = UIColor.gray
        control.selectedSegmentTintColor = UIColor.init(hex: "0xACC649")
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        control.setTitleTextAttributes(titleTextAttributes, for:.normal)
        control.setTitleTextAttributes(titleTextAttributes, for:.selected)
        
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        control.selectedSegmentIndex = 0;
        
        return control
    }()
    
    private let milesToMetersArray: [Double] = [24141, 40234, 80468, 160934]
    
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
        self.currentRadius = self.milesToMetersArray[0]
        self.view.backgroundColor = .white
        self.navigationItem.titleView = self.labelTitle
        
        self.bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        self.bannerView.adUnitID = "ca-app-pub-7088839014127907/5824681329"
        self.bannerView.rootViewController = self
        self.bannerView.delegate = self
        self.bannerView.load(GADRequest())
        
        self.getUserCoordinates()
        
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
        
        self.view.addSubview(self.stackViewBannerAds)
        self.stackViewBannerAds.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(0).priority(250);
        }
        
        self.view.addSubview(self.segmentedControlMiles)
        self.segmentedControlMiles.snp.makeConstraints { (make) in
            make.top.equalTo(self.stackViewBannerAds.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
        
        self.view.addSubview(self.mapView)
        self.mapView.snp.makeConstraints { (make) in
            make.top.equalTo(self.segmentedControlMiles.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
    }
    private func getUserCoordinates() {
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
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
        self.getUserCoordinates()
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
                            for (key, value) in self.companies {
                                let annotation = MKPointAnnotation()
                                annotation.title = key
                                annotation.coordinate = CLLocationCoordinate2D(latitude: value.latitude, longitude: value.longitude)
                                self.mapView.addAnnotation(annotation)
                            }
                            
                            let mapCamera = MKMapCamera(lookingAtCenter: locValue, fromEyeCoordinate: locValue, eyeAltitude: self.currentRadius)
                            self.mapView.setCamera(mapCamera, animated: true)
                            
                            manager.stopUpdatingLocation()
                        }
                        index+=1
                    } failure: { (error) in
                        
                    }
                }
            } failure: { (error) in
                
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
    
    // MARK: - Public API
    
    // MARK: Delegate Methods
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        self.bannerView = bannerView
        self.stackViewBannerAds.addArrangedSubview(self.bannerView)
        print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    
}
