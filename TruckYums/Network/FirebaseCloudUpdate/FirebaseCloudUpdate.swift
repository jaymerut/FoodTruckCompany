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
