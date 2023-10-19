//
//  NetworkingManagerUserDetailsResponseFailureMock.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 19.10.23.
//

// Integration Test
// Created Swift Class and add @testable import project

import Foundation
@testable import PersonalPeopleAPI

class NetworkingManagerUserDetailsResponseFailureMock: NetworkingManagerImpl {
    
    /**
     In this function we are going to use StaticJSONMapper to decode SingleUserData file and use the Type T
     */
    func request<T>(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
       // Here we just throw an error
        throw NetworkingManager.NetworkingError.invalidUrl
    }
    
    // We dont use this actually so keep that empty
    func request(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint) async throws {}
    
    
}
