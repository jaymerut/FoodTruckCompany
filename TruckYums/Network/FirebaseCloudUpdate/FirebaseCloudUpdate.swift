//
//  FirebaseCloudUpdate.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/9/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit
import Firebase


class FirebaseCloudUpdate: NSObject {
    
    
    // MARK: - Variables
    
    
    
    // MARK: - Initialization
    private func customInitFirebaseCloudUpdate() {
        
    }
    override init() {
        super.init()
        
        customInitFirebaseCloudUpdate()
    }
    
    
    
    // MARK: - Private API
    
    
    
    // MARK: - Public API
    public func firebaseAddUser(newUser: User, completion: @escaping (_ user: User?) -> Void) {
        let collection = Firestore.firestore().collection("Users")
        
        collection.document(newUser.email).setData(["email": newUser.email, "name": newUser.name, "password": newUser.password, "phonenumber": newUser.phonenumber, "company": newUser.company]) { err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(nil)
            } else {
                print("Document succesfully created")
                completion(newUser)
            }
        }
    }
    public func firebaseAddCompany(newCompany: Company, completion: @escaping (_ company: Company?) -> Void) {
        let collection = Firestore.firestore().collection("Companies")
        
        collection.document(newCompany.name).setData(["name": newCompany.name, "latitude": newCompany.latitude, "longitude": newCompany.longitude, "linkedwith": newCompany.linkedwith, "venderverified": newCompany.venderverified, "cuisine": newCompany.cuisine, "phonenumber": newCompany.phonenumber, "siteurl": newCompany.siteurl, "lastupdated": newCompany.lastupdated, "hours": newCompany.hours]) { err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(nil)
            } else {
                print("Document succesfully created")
                completion(newCompany)
            }
        }
    }
    
    public func firebaseUpdateUser(modifiedUser: User, completion: @escaping (_ user: User?) -> Void) {
        let collection = Firestore.firestore().collection("Users")
 
        collection.document(modifiedUser.email).updateData(["name": modifiedUser.name, "phonenumber": modifiedUser.phonenumber,]) {
            err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(nil)
            } else {
                print("Document succesfully updated")
                completion(modifiedUser)
            }
        }
    }
    public func firebaseUpdateUserPassword(modifiedUser: User, completion: @escaping (_ user: User?) -> Void) {
        let collection = Firestore.firestore().collection("Users")
 
        collection.document(modifiedUser.email).updateData(["password": modifiedUser.password,]) {
            err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(nil)
            } else {
                print("Document succesfully updated")
                completion(modifiedUser)
            }
        }
    }
    public func firebaseUpdateCompany(modifiedCompany: Company, completion: @escaping (_ user: Company?) -> Void) {
        let collection = Firestore.firestore().collection("Companies")
 
        collection.document(modifiedCompany.name).updateData(["lastupdated": modifiedCompany.lastupdated, "phonenumber": modifiedCompany.phonenumber, "hours": modifiedCompany.hours, "cuisine": modifiedCompany.cuisine]) {
            err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(nil)
            } else {
                print("Document succesfully updated")
                completion(modifiedCompany)
            }
        }
    }
    public func firebaseUpdateLocation(company: String, latitude: Double, longitude: Double, completion: @escaping () -> Void) {
        let collection = Firestore.firestore().collection("Companies")
 
        collection.document(company).updateData(["latitude": latitude, "longitude": longitude,]) {
            err in
            if let err = err {
                print("Error updating document: \(err)")
                completion()
            } else {
                print("Document succesfully updated")
                completion()
            }
        }
    }
    
}
