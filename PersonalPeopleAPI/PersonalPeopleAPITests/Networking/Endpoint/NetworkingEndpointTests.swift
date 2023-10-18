//
//  NetworkingEndpointTests.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 18.10.23.
//

import XCTest
@testable import PersonalPeopleAPI

final class NetworkingEndpointTests: XCTestCase {

    func test_with_people_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.people(page: 1)
        
        // Check for host type is correct
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        // Check for path is correct
        XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
        // Check for method type is correct
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        // Check for Query Item for Page Number One
        XCTAssertEqual(endpoint.queryItems, ["page":"1"], "This query item should be page:1")
        // Final Check for final Url build by our endpoints
        XCTAssertEqual(endpoint.url?.absoluteString,"https://reqres.in/api/users?page=1&delay=2","The generatd does not match our endpoint")
    }
    
    func test_with_detail_endpoint_request_is_valid() {
        let userId = 1
        let endpoint = Endpoint.detail(id: userId)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users/\(userId)", "The path should be /api/users/\(userId)")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        XCTAssertNil(endpoint.queryItems, "The query items should be nil")
        XCTAssertEqual(endpoint.url?.absoluteString,"https://reqres.in/api/users/\(userId)?delay=2","The generatd does not match our endpoint")
    }
    
    func test_with_create_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.create(submissionData: nil)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
        XCTAssertEqual(endpoint.methodType, .POST(data: nil), "The method type should be POST")
        XCTAssertNil(endpoint.queryItems, "The query items should be nil")
        XCTAssertEqual(endpoint.url?.absoluteString,"https://reqres.in/api/users?delay=2","The generatd does not match our endpoint")
    }
    
    

}
