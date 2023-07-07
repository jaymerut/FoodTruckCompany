//
//  File.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 7/3/23.
//  Copyright © 2023 truckyums. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {
    
    func encrypt() -> String {
        let key = Constants.encryptionKey
        let iv = Constants.encryptionIv
        let data = self.data(using: .utf8)!
        let encrypted = try! AES(key: Array(key.utf8), blockMode: CBC.init(iv: Array(iv.utf8)), padding: .pkcs7).encrypt([UInt8](data));
//        let encrypted = try! AES(key: key, blockMode: .CBC, padding: .pkcs7) //AES(key: key, iv: iv, blockMode: .CBC, padding: .pkcs7).encrypt([UInt8](data))
        let encryptedData = Data(encrypted)
        return encryptedData.base64EncodedString()
    }
    
    func decrypt() -> String {
        let key = Constants.encryptionKey
        let iv = Constants.encryptionIv
        let data = Data(base64Encoded: self)!
        let decrypted = try! AES(key: Array(key.utf8), blockMode: CBC.init(iv: Array(iv.utf8)), padding: .pkcs7).decrypt([UInt8](data));
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
        
    }
}
