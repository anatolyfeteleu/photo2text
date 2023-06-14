//
//  AdviceServiceImp.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 19.02.2023.
//

import Foundation
import Combine
import Alamofire


class AdviceServiceImp: AdviceService {
    var apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getAdvices<T>(model: T.Type) -> AnyPublisher<T?, DataResponsePublisher<Data>.Failure> where T : DecodableFromDTO {
        return apiClient.loadData(AdviceRouter.advice, model: model)
    }
}
