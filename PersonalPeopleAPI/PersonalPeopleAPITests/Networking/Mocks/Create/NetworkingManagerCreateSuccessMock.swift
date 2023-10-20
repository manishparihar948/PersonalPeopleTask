//
//  NetworkingManagerCreateSuccessMock.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 20.10.23.
//

/**
 This is the first mock we create networking manager create success so this is going to simulates
 a successfull request so
 */
import Foundation

// Then add testable project
@testable import PersonalPeopleAPI

// This is our mock for our success when we are using our create view model
class NetworkingManagerCreateSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint) async throws {
        
    }
    
    
}
