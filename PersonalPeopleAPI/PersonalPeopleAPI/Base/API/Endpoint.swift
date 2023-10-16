//
//  Endpoint.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 16.10.23.
//

import Foundation

enum Endpoint {
    case people
    case detail(id: Int)
    case create(submissionData: Data?)
}

// For GET and POST Method
extension Endpoint {
    enum MethodType {
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
}

extension Endpoint {
    
    var url: URL? {
        // mark as Optional if failed and we want to return empty url
        // "https://reqres.in/api/users/\(id)?delay=3"
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        #if DEBUG // if your app is working on debug mode its going to add in the code within this block here
        // so we actually release ths app onto the app store we are not going to have this additional delay that
        // we use to debug
        urlComponents.queryItems = [
            URLQueryItem(name: "delay", value: "1")
        ]
        #endif
        
        return urlComponents.url
    }
}
