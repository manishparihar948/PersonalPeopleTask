//
//  NetworkingManagerUserDetailsResponseSuccess.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 19.10.23.
//

#if DEBUG
/**
 Because of making global use of this testing class we need to Change Target Membership
 And comment @testable import PersonalPeopleAPI
 */

// Integration Test
// Created Swift Class and add @testable import project

import Foundation
// @testable import PersonalPeopleAPI

class NetworkingManagerUserDetailsResponseSuccessMock: NetworkingManagerImpl {
    
    /**
     In this function we are going to use StaticJSONMapper to decode SingleUserData file and use the Type T
     */
    func request<T>(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self) as! T
    }
    
    // We dont use this actually so keep that empty
    func request(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint) async throws {}
}

#endif
