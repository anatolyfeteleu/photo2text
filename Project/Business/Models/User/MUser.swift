//
//  User.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 20.03.2023.
//

import Foundation

enum Sex: String {
    case male, female, unknown
}


class MUser: NSObject, NSCoding {
    let username: String
    let sex: Sex
    
    required init?(coder: NSCoder) {
        username = coder.decodeObject(forKey: "username") as? String ?? ""
        sex = Sex(rawValue: coder.decodeObject(forKey: "sex") as? String ?? Sex.unknown.rawValue) ?? .unknown
    }
    
    init(username: String, password: String, sex: Sex = .unknown) {
        self.username = username
        self.sex = sex
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(username, forKey: "username")
        coder.encode(sex, forKey: "sex")
    }
    
}


final class MUserDefaults {
    
    private enum Keys: String {
        case userModel, username
    }
    
    static var username: String {
        get {
            let defaults = UserDefaults.standard
            let key = Keys.username.rawValue
            
            return defaults.string(forKey: key) ?? ""
        }
        set {
            let defaults = UserDefaults.standard
            let key = Keys.username.rawValue
            
            defaults.set(newValue, forKey: key)
        }
    }
    
    static var userModel: MUser! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: Keys.userModel.rawValue) as? Data,
                  let decodedData = try? NSKeyedUnarchiver.unarchivedObject(ofClass: MUser.self, from: savedData)
            else { return nil }
            return decodedData
        }
        set {
            let defaults = UserDefaults.standard
            let key = Keys.userModel.rawValue
            
            if let userModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
}
