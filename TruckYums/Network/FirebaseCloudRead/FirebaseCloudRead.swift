//
//  FirebaseCloudRead.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 12/9/20.
//  Copyright © 2020 truckyums. All rights reserved.
//

import UIKit
import Firebase

class FirebaseCloudRead: NSObject {
    
    
    // MARK: - Variables
    private var documents: [DocumentSnapshot] = []
    private var listener : ListenerRegistration!
    
    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
            }
        }
    }
    
    // MARK: - Initialization
    private func customInitFirebaseCloudRead() {
        
    }
    override init() {
        super.init()

        customInitFirebaseCloudRead()
    }
    
    
    
    // MARK: - Private API
    fileprivate func baseQuery(collectionName: String) -> Query {
        // Uncomment when new fields are added and need to reset cache
        Firestore.firestore().clearPersistence { (error) in
            print(error as Any)
        }
 
        return Firestore.firestore().collection(collectionName)
    }
    
    
    // MARK: - Public API
    public func firebaseReadCompanies(completion: @escaping (_ companies: [Company]?) -> Void) {
        self.query = nil
        self.listener = nil
        self.query = baseQuery(collectionName: "Companies")
        self.listener = query?.addSnapshotListener { (documents, error) in
            guard let snapshot = documents else {
                print("Error fetching documents results: \(error!)")
                return
            }
             
            let results = snapshot.documents.map { (document) -> Company in
                if let company = Company(dictionary: document.data(), id: document.documentID) {
                    return company
                } else {
                    fatalError("Unable to initialize type \(Company.self) with dictionary \(document.data())")
                }
            }
             
            self.documents = snapshot.documents
            completion(results)
        }
    }
    public func firebaseReadUsers(completion: @escaping (_ users: [User]?) -> Void) {
        self.query = nil
        self.listener = nil
        self.query = baseQuery(collectionName: "Users")
        self.listener =  query?.addSnapshotListener { (documents, error) in
            guard let snapshot = documents else {
                print("Error fetching documents results: \(error!)")
                return
            }
             
            let results = snapshot.documents.map { (document) -> User in
                if let user = User(dictionary: document.data(), id: document.documentID) {
                    return user
                } else {
                    fatalError("Unable to initialize type \(User.self) with dictionary \(document.data())")
                }
            }
             
            self.documents = snapshot.documents
            completion(results)
        }
    }
    
    
}
