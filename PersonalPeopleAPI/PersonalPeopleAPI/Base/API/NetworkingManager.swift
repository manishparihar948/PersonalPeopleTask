//
//  NetworkingManager.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 13.10.23.
//

import Foundation

// Protocol added for Integration Testing
protocol NetworkingManagerImpl {
    // We want to move our request here, we take out default .shared ffrom session.
    func request<T: Codable>(session: URLSession,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T
    
    func request(session: URLSession,
                 _ endpoint: Endpoint) async throws
}

/*
   Entire Singleton class
   
*/
final class NetworkingManager: NetworkingManagerImpl {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    /*
        Refactor the code in NetworkManager to make our code easier,And for this use Swift Concurrency
        For that first remove closure
        And make asynchronous,throws an error so mark with throws
        
     */
    // Make generic constraint so make request with Type T and Codable
    // We want to actually pass in a type so we allow someone to say the model that they want to map it to within the request function so we are going to say type and want that type to be T.type
    func request<T: Codable>(session: URLSession = .shared,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T {

        // 1. Check if endpoint are valid
        guard let url = endpoint.url else {
            throw NetworkingError.invalidUrl
        }
        
        // 2. Build Request
        let request = buildRequest(from: url, methodType: endpoint.methodType)
       
        // 3. Try and execute a fetch request and await a value
        /*
        // what we telling our system that we want to try so this funtion throw an error so we try to fetch some data and
        //we are going to await the value so this (it tells the system that something asynchronous is about to happen and
        //it will actually suspend and wait for it to finish)
        */
        let (data, response) = try await session.data(for: request)
        
        // 4. We access the response to check if its within a valid status code if isnt we going to throw an error
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        // 5. Try to decode objects using the json decoder
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from:data)
        
        // 6. If everything goods we return the value orelse we throw the error from the above point number 5 function
        return res // we want return from this funtion thatswhy we use T
    }
    
    // POST Request - 
    // method overloading two funtions name is same but behave differently
    // Here we don not want return from this function
    func request(session: URLSession = .shared,
                 _ endpoint: Endpoint) async throws  {
        guard let url = endpoint.url else {
            throw NetworkingError.invalidUrl
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (_, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error:Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

// Added this because our NetworkingManagerTest for unsuccessful for 400 got error
extension NetworkingManager.NetworkingError: Equatable {
    static func == (lhs: NetworkingManager.NetworkingError, rhs: NetworkingManager.NetworkingError) -> Bool {
        switch(lhs, rhs) {
            // compare whoever for case
        case (.invalidUrl, .invalidUrl):
            return true
        case (.custom(let lhsType), .custom(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case (.invalidData, .invalidData):
            return true
        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
            
        }
    }
}

extension NetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "URL isn't valid"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Failed to decode"
        case .custom(let err):
            return "Something went wrong \(err.localizedDescription)"
        }
    }
}

// i dont want to expose the extension to access outside this network manager
private extension NetworkingManager {
    func buildRequest(from url:URL,
                      methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url:url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        return request
    }
}
