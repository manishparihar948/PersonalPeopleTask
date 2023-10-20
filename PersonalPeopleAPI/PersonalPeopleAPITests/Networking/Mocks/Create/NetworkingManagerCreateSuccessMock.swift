//
//  NetworkingManagerCreateSuccessMock.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 20.10.23.
//

/**
 We dont want our Networking Manager to be there when build for app store so
 we will use macros here, so all these files will not be include in our final build
 And remember always To Change the Target Ownership of this file becase
 the Target Membership we have sets for UnitTesting (PersonalPeopleAPITests)
 now make it as Main Target as PersonalPeopleAPI. So  our Unit Test can access
 them by the app testable import and also our uitesting file will be able to use it
 within our main application, we should get  error saying that you cant use it in main target membership.
 So we need to remove our @testable import
 */
#if DEBUG
/**
 This is the first mock we create networking manager create success so this is going to simulates
 a successfull request so
 */
import Foundation

// Then add testable project
// @testable import PersonalPeopleAPI

// This is our mock for our success when we are using our create view model
class NetworkingManagerCreateSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: PersonalPeopleAPI.Endpoint) async throws {
        
    }
}
#endif
