//
//  NetworkingManagerUserResponseSuccessMock.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 19.10.23.
//

#if DEBUG
import Foundation
/**
 Because of making global use of this testing class we need to Change Target Membership
 And comment @testable import PersonalPeopleAPI
 */
//@testable import PersonalPeopleAPI

/**
 This class is going to implement the protocol we created before
    
 */
class NetworkingManagerUserResponseSuccessMock: NetworkingManagerImpl {
    
    /*
      return static json mapper basically return back data that we have within
     our json file simulate that flow so set this now. and we force cast as generic T
     which is type codable.
     */
    func request<T>(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self) as! T
    }
    
    // Leave this empty
    func request(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint) async throws { }
    
    
}

#endif
