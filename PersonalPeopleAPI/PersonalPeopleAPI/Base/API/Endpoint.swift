//
//  Endpoint.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 16.10.23.
//

import Foundation

enum Endpoint {
    case people(page:Int) // For pagination and infinite scrolling
    case detail(id: Int)
    case create(submissionData: Data?)
}

// For GET and POST Method
extension Endpoint {
    /**
        MethodType cannot automatically confront  to the equatable protocol, the reason why that is because
        our POST case is actually associated with a value, if its does not have value then we automatically able
        to compare our enum cases because it has value here what we need to do is make MethodType : Equatable
        then go back to Unit test the error will disappear
     */
    enum MethodType: Equatable {
        case GET
        case POST(data: Data?) // Optional:  In case we dont wanna send data
    }
}

extension Endpoint {
    var host: String { "reqres.in" }
    
    var path: String {
        switch self {
        case .people,
             .create:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
        /*
         // Because we have same api for people and create
        case .create:
            return "/api/users"
         */
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .people,
             .detail:
            return .GET
        case .create(let data):
            return .POST(data: data)
        }
    }
    
    // Query Item for infinite scroll and pagination
    var queryItems: [String: String]? {
        switch self {
        case .people(let page):
            return ["page":"\(page)"]
        default :
            return nil
        }
    }
}

extension Endpoint {
    
    var url: URL? {
        // mark as Optional if failed and we want to return empty url
        // "https://reqres.in/api/users/\(id)?delay=3"
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        // Create an array of QueryItem because the test fails in NetworkingEndpointTest
        // test_with_detail_endpoint_request_is_valid
        var requestQueryItems = [URLQueryItem]()
        
        queryItems?.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        // loop through our dictionary & create an array of url query items
        // so we are going to use to do that by using compact map reason of using this
        // actually help to filter out any nil values as well
        /*
         // Comment this code once you put line 81 to 85 for unit test
        var requestQueryItems = queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        */
        
        #if DEBUG // if your app is working on debug mode its going to add in the code within this block here
        // so we actually release ths app onto the app store we are not going to have this additional delay that
        // we use to debug
        // remove ? when writing unit test
        requestQueryItems.append(URLQueryItem(name: "delay", value: "2"))
        #endif
        
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}
