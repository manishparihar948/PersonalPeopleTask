//
//  StaticJSONMapper.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//

import Foundation

struct StaticJSONMapper {
    
    // T constraint because we want return
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
         guard !file.isEmpty,
                let path = Bundle.main.path(forResource: file, ofType: "json"),
                let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContents
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // let result = try decoder.decode(UsersResponse.self, from: data)
        // instead of this line use below to make it Generic
        return try decoder.decode(T.self, from: data)
    }
}

extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContents
        
    }
}
