//
//  NetworkingManagerCreateFailureMock.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 20.10.23.
//

import Foundation
// Then add testable project
@testable import PersonalPeopleAPI

// This is our mock for our success when we are using our create view model
class NetworkingManagerCreateFailureMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return Data() as! T
    }
    
    // Throw some kind of error in this funtion
    func request(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint) async throws {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
    
    
}
