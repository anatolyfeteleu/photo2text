//
//  MAdvice.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 17.02.2023.
//

import Foundation

protocol DecodableFromDTO {
    associatedtype DTO: Decodable
    init(from dto: DTO) throws
}


extension JSONDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : DecodableFromDTO {
        try T(from: decode(T.DTO.self, from: data))
    }
}


struct MAdvice: DecodableFromDTO, Equatable {
    struct DTO: Decodable {
        struct Slip: Decodable {
            var id: Int
            var advice: String
        }
        
        var slip: Slip
    }
    
    var id: Int
    var advice: String
    
    init(from dto: DTO) {
        id = dto.slip.id
        advice = dto.slip.advice
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
