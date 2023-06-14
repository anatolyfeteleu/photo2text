//
//  Advice.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 07.02.2023.
//

import Alamofire


enum AdviceRouter: URLRequestConvertible {
    case advice
}

extension AdviceRouter: RequestProtocol {
    var path: String {
        switch self {
        case .advice: return "advice"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .advice:
            return .get
        }
    }
    
    var useToken: Bool {
        switch self {
        case .advice: return false
        }
    }
        
}
