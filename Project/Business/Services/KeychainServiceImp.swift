//
//  Storage.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 20.03.2023.
//

import Foundation
import KeychainAccess


final class KeychainServiceImp: KeychainServiceProtocol {
    
    private lazy var keychain: Keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    
    // MARK: - KeychainServiceProtocol methods
    
    func save(key: String, value: String) {
        do {
            try keychain.set(value, key: key)
        }
        catch {
            print("Error set value \(key): \(value) to keychain")
        }
    }
    
    func get(key: String) -> String? {
        return try? keychain.getString(key)
    }
    
    func remove(key: String) {
        do {
            try keychain.remove(key)
        }
        catch {
            print("Error remove key \(key) from keychain")
        }
    }
    
    // MARK: KeychainServiceProtocol methods -
    
}
