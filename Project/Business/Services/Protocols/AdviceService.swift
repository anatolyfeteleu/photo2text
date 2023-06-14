//
//  AdviceService.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 19.02.2023.
//

import Foundation
import Combine
import Alamofire


protocol AdviceService {
    func getAdvices<T: DecodableFromDTO>(model: T.Type) -> AnyPublisher<T?, DataResponsePublisher<Data>.Failure>
}
