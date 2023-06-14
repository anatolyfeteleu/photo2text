//
//  APIClient.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 09.02.2023.
//

import Foundation
import Combine
import Alamofire



class APIClient {
    let queue: DispatchQueue
    let configuration = URLSessionConfiguration.default
    var sessionManager: Session
    
    init(queue: DispatchQueue = DispatchQueue.main) {
        self.queue = queue
        self.sessionManager = Session(configuration: configuration)
    }
    
    func loadData<T: URLRequestConvertible, M: DecodableFromDTO>(_ urlRequest: T, model: M.Type) -> AnyPublisher<M?, DataResponsePublisher<Data>.Failure> {
        return sessionManager.request(urlRequest)
            .publishData()
            .map { try? JSONDecoder().decode(M.self, from: $0.value!) }
            .eraseToAnyPublisher()
    }
}
