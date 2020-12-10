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


class FindFoodTrucksViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    // MARK: - Variables
    public var companies: [Company] = []
    
    let distanceSpan: Double = 50
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView.init(frame: .zero)
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsScale = true
        mapView.showsCompass = false
        mapView.showsUserLocation = true
        
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
        self.view.backgroundColor = .white
        
        self.firebaseCloudRead.firebaseReadCompanies { (companies) in
            self.companies = companies ?? [Company]()
            self.getUserCoordinates()
        }
        
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
        
        self.view.addSubview(self.mapView)
        self.mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
    }
    private func getUserCoordinates() {
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
    }
    
    // MARK: Delegate Methods
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        let region = MKCoordinateRegion.init(center: newLocation.coordinate, latitudinalMeters: self.distanceSpan, longitudinalMeters: self.distanceSpan)
        self.mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let currentLocation:CLLocation = locations.last ?? CLLocation.init()
        
        for company in self.companies {
            let annotation = MKPointAnnotation()
            annotation.title = company.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: company.latitude, longitude: company.longitude)
            mapView.addAnnotation(annotation)
        }
        
        let mapCamera = MKMapCamera(lookingAtCenter: locValue, fromEyeCoordinate: locValue, eyeAltitude: 15000)
        mapView.setCamera(mapCamera, animated: true)
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    // MARK: - Public API
    
    
    
}
