//
//  RequestProtocol.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 07.02.2023.
//

import Foundation
import Alamofire


protocol RequestProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var queryParameters: Parameters { get }
    var queryParametersEncoding: ParameterEncoding { get }
    var useToken: Bool { get }
}
