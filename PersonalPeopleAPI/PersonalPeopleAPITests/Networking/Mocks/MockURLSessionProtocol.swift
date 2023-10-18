//
//  MockURLSessionProtocol.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 18.10.23.
//

import Foundation
import XCTest

// This URLProtocol allows us to actually control, how our data is going to be loaded when we want to use some kind of request with our network manager url
class MockURLSessionProtocol: URLProtocol {
    
    /**
     its going to void but we are going to be able to actually return some kind of values
     the value we want to return is HTTPURLResponse and some Data and make it optional
     Reason why we returning the data inside closure is  i can actually set within the network request that we simulate
     the status code and any data that we get back from this fake url session.
     So this handler withing our actual start loading function
     */
    static var loadingHandler: (() -> (HTTPURLResponse, Data?))?
    
    
    /**
     What its allow to do?
     Its actually control whether it can handle a given request
     now in our case we actually want it to always return true because we always want
     it to return some kind of value for when we try to execute this fake request
     */
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    /**
     What it does?
     It actually returns a fake version of the request sow we are just going to return our request that we pass in herere
     */
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    /**
     What it does ?
     It actually control the mock response that we get back form this fake url session that we are going to build
     but we need to write some kind of closure to actually help us handle simulating our request and we are actually going to
     tackle step by step.
     */
    override func startLoading() {
        guard let handler = MockURLSessionProtocol.loadingHandler else {
            XCTFail("Loading handler is not set.")
            return
        }
        
        let (response, data) = handler()
        
        /**
         Send back response and data
         basically we make sure we never cache any of this api data
         on to the device during our test because we want it to always be within a fresh
         state whenever we are actually running our test
         
         */
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        /**
         next we need to set our data
         this is going to send back the data within our url session and we are going to send back the data or pass through
         */
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        /**
         finaly we tell our client that we actually finish loading
         */
        client?.urlProtocolDidFinishLoading(self)
        
        /**
         what we need to do now is actually create a test file to actually simulate what actually testing out a successful response
         so to do this within our Networking folder create called NetworkingManager and create new test class called NetworkingManagerTests
         */
    }
    
    override func stopLoading() {
        
    }
}
