//
//  NetworkingManagerUserResponseFailureMock.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 19.10.23.
//

#if DEBUG
/**
 Because of making global use of this testing class we need to Change Target Membership
 And comment @testable import PersonalPeopleAPI
 */
import Foundation
// @testable import PersonalPeopleAPI

class NetworkingManagerUserResponseFailureMock: NetworkingManagerImpl {
    
    // we are just want to throw an error to check how our view model can handle this, w/o any other test
    func request<T>(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
    
    // leave it empty becase we dont use this function within our PeopleViewModel
    func request(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint) async throws {}
    
    
}

#endif
