//
//  Constants.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 07.02.2023.
//

import Foundation


struct Constants {
    struct Network {
        enum ServerType {
            case develop, production
        }
        struct AdviceAPI {
            static var server: ServerType { .develop }
            static var apiPathComponent: String {
                switch server {
                case .develop: return ""
                case .production: return "api"
                }
            }
            static var baseURL: URL {
                switch server {
                case .develop: return URL(string: "https://api.adviceslip.com")!
                case .production: return URL(string: "https://api.adviceslip.com")!
                }
            }
            
        }
    }
}
