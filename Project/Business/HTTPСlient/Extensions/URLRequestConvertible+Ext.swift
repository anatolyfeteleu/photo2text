//
//  URLRequestConvertible+Ext.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 07.02.2023.
//

import Foundation
import Alamofire


extension URLRequestConvertible where Self: RequestProtocol  {
    
    func asURLRequest() throws -> URLRequest {
        var baseURL = Constants.Network.AdviceAPI.baseURL
        let apiPathComponent = Constants.Network.AdviceAPI.apiPathComponent
        
        baseURL.appendPathComponent(apiPathComponent, conformingTo: .url)
        baseURL.appendPathComponent(self.path, conformingTo: .url)
        
        let urlRequest = try URLRequest(url: baseURL, method: self.method, headers: self.headers)
        let urlRequestEncoded = try self.queryParametersEncoding.encode(urlRequest, with: self.queryParameters)
        
        return urlRequestEncoded
    }

}
