//
//  NetworkingManager.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 13.10.23.
//

import Foundation

// Entire Singleton class
final class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    // Make generic constraint so make request with Type T and Codable
    // We want to actually pass in a type so we allow someone to say the model that they want to map it to within the request function so we are going to say type and want that type to be T.type
    func request<T: Codable>(_ absoluteURL: String,
                             type: T.Type,
                             completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: absoluteURL) else {
            completion(.failure(NetworkingError.invalidUrl))
            return //Return here to make sure that you actually stop execution after your call your completion handler like so
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let res = try decoder.decode(T.self, from:data)
                completion(.success(res))
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
        }
        
        dataTask.resume() // We need to resume it if not then its going to execute the request where it actually fetches the data so what will happen is that you wont actually see your request being made so you need to make sure that you call resume on your urlsession data task
    }
}

extension NetworkingManager {
    enum NetworkingError: Error {
        case invalidUrl
        case custom(error:Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}
