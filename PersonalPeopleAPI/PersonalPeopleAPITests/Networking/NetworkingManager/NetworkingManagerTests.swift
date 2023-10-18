//
//  NetworkingManagerTests.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 18.10.23.
//

import XCTest
@testable import PersonalPeopleAPI

final class NetworkingManagerTests: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!
    
    override func setUp() {
        url = URL(string: "https://reqres.in/users")
        
        /** 
         why we are using this session configuraiton here is because between each and every single one of our tests we
            want to make sure that the state of them is clean
         */
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        url = nil
    }

    func test_with_successful_response_response_is_valid() async throws {
        // Get the JSON
        guard let path = Bundle.main.path(forResource: "UsersStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Fail to get the static user file")
            return
        }
        
        // Create and set response
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, data)
        }
        
        let res = try await NetworkingManager.shared.request(session: session,
                                                       .people(page:1),
                                                       type: UsersResponse.self)
        
        let staticJSON = try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        
        XCTAssertEqual(res, staticJSON, "The returned response should be decoded properly")
    }
    
    func test_with_successful_response_void_is_valid() async throws {
        
        // Create and set response
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        // type is not required because we are not validating against type
        _ = try await NetworkingManager.shared.request(session: session,
                                                       .people(page: 1))
    }

    func test_with_unsuccessful_response_code_in_invalid_range_is_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session,
                                                           .people(page: 1),
                                                           type: UsersResponse.self)
        } catch  {
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            XCTAssertEqual(networkingError,
                           NetworkingManager.NetworkingError.invalidStatusCode(statusCode: invalidStatusCode),
                           "Error should be a networking error which throws an invalid status code")
        }
    }
    
    func test_with_unsuccessful_response_code_void_in_invalid_range_is_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session,
                                                           .people(page: 1))
        } catch {
            
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            
            XCTAssertEqual(networkingError,
                           NetworkingManager.NetworkingError.invalidStatusCode(statusCode: invalidStatusCode),
                           "Error should be a networking error which throws an invalid status code")
            
        }
    }
    
    func test_with_successful_response_with_invalid_json_is_invalid() async {
        
        guard let path = Bundle.main.path(forResource: "UsersStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, data)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session,
                                                           .people(page: 1),
                                                           type: UserDetailResponse.self)
        } catch {
            if error is NetworkingManager.NetworkingError {
                XCTFail("The error should be a system decoding error")
            }
        }
    }
}
