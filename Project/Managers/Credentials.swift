//
//  Credentials.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 20.03.2023.
//

import Foundation


class Credentials {
    enum CrentialsKeys: String {
        case authState = "home.authPet.authState"
    }
    
    static let shared: Credentials = {
        let credentials = Credentials()
        credentials.configure()
        return credentials
    }()
    
    private let service: KeychainServiceImp = KeychainServiceImp()
    
    var isAuthorized: Bool {
        return self.service.get(key: CrentialsKeys.authState.rawValue) != nil
    }
    
    // MARK: - Public methods
    
    func login() {
        service.save(key: CrentialsKeys.authState.rawValue, value: String(true))
    }
    
    func logout() {
        service.remove(key: CrentialsKeys.authState.rawValue)
    }
        
    // MARK: - Private methods
    
    private func configure() {
        load()
    }
    
    private func load() {
        _ = getAuthState()
    }
    
    private func getAuthState() -> String? {
        return service.get(key: CrentialsKeys.authState.rawValue)
    }
        
}
