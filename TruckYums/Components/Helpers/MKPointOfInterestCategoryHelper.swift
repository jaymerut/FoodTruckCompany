//
//  MKPointOfInterestCategoryHelper.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/29/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit


class MKPointOfInterestCategoryHelper: NSObject {
    
    
    // MARK: - Variables
    let airport = "MKPOICategoryAirport"
    let amusementPark = "MKPOICategoryAmusementPark"
    let aquarium = "MKPOICategoryAquarium"
    let atm = "MKPOICategoryATM"
    let bakery = "MKPOICategoryBakery"
    let bank = "MKPOICategoryBank"
    let beach = "MKPOICategoryBeach"
    let brewery = "MKPOICategoryBrewery"
    let cafe = "MKPOICategoryCafe"
    let campground = "MKPOICategoryCampground"
    let carRental = "MKPOICategoryCarRental"
    let evCharger = "MKPOICategoryEVCharger"
    let fireStation = "MKPOICategoryFireStation"
    let fitnessCenter = "MKPOICategoryFitnessCenter"
    let foodMarket = "MKPOICategoryFoodMarket"
    let gasStation = "MKPOICategoryGasStation"
    let hospital = "MKPOICategoryHospital"
    let hotel = "MKPOICategoryHotel"
    let laundry = "MKPOICategoryLaundry"
    let library = "MKPOICategoryLibrary"
    let marina = "MKPOICategoryMarina"
    let movieTheater = "MKPOICategoryMovieTheater"
    let museum = "MKPOICategoryMuseum"
    let nationalPark = "MKPOICategoryNationalPark"
    let nightlife = "MKPOICategoryNightlife"
    let park = "MKPOICategoryPark"
    let parking = "MKPOICategoryParking"
    let pharmacy = "MKPOICategoryPharmacy"
    let police = "MKPOICategoryPolice"
    let postOffice = "MKPOICategoryPostOffice"
    let publicTransport = "MKPOICategoryPublicTransport"
    let restaurant = "MKPOICategoryRestaurant"
    let restroom = "MKPOICategoryRestroom"
    let school = "MKPOICategorySchool"
    let stadium = "MKPOICategoryStadium"
    let store = "MKPOICategoryStore"
    let theater = "MKPOICategoryTheater"
    let university = "MKPOICategoryUniversity"
    let winery = "MKPOICategoryWinery"
    let zoo = "MKPOICategoryZoo"
    
    
    // MARK: - Initialization
    private func customInitMKPointOfInterestCategoryHelper() {
        
    }
    override init() {
        super.init()
        
        customInitMKPointOfInterestCategoryHelper()
    }
    
    
    
    // MARK: - Private API
    
    
    
    // MARK: - Public API
    public func convertRawValueToStringValue(rawValue: String) -> String {
        switch rawValue {
        case airport:
            return "Airport"
        case amusementPark:
            return "Amusement Park"
        case aquarium:
            return "Aquarium"
        case atm:
            return "ATM"
        case bakery:
            return "Bakery"
        case bank:
            return "Bank"
        case beach:
            return "Beach"
        case brewery:
            return "Brewery"
        case cafe:
            return "Cafe"
        case campground:
            return "Campground"
        case carRental:
            return "Car Rental"
        case evCharger:
            return "EV Charger"
        case fireStation:
            return "Fire Station"
        case fitnessCenter:
            return "Fitness Center"
        case foodMarket:
            return "Food Market"
        case gasStation:
            return "Gas Station"
        case hospital:
            return "Hospital"
        case hotel:
            return "Hotel"
        case laundry:
            return "Laundry"
        case library:
            return "Library"
        case marina:
            return "Marina"
        case movieTheater:
            return "Movie Theater"
        case museum:
            return "Museum"
        case nationalPark:
            return "National Park"
        case nightlife:
            return "Nightlife"
        case park:
            return "Park"
        case parking:
            return "Parking"
        case police:
            return "Police"
        case postOffice:
            return "Post Office"
        case publicTransport:
            return "Public Transport"
        case restaurant:
            return "Restaurant"
        case restroom:
            return "Restroom"
        case school:
            return "School"
        case stadium:
            return "Stadium"
        case store:
            return "Store"
        case theater:
            return "Theater"
        case university:
            return "University"
        case winery:
            return "Winery"
        case zoo:
            return "Zoo"
        default:
            return "Food Truck"
        }
    }
    
    
}
