//
//  KeychainServiceProtocol.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 20.03.2023.
//

import Foundation


protocol KeychainServiceProtocol {
    func save(key: String, value: String)
    func get(key: String) -> String?
    func remove(key: String)
}
