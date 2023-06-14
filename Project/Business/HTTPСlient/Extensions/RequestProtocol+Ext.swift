//
//  RequestProtocol+Ext.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 07.02.2023.
//

import Foundation
import Alamofire


extension RequestProtocol {
    var headers: HTTPHeaders {
        [:]
    }
    var queryParameters: Parameters {
        [:]
    }
    var queryParametersEncoding: ParameterEncoding {
        URLEncoding(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
    }
}
