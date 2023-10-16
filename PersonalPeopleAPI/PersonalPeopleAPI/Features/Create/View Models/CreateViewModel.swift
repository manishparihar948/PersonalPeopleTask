//
//  CreateViewModel.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 16.10.23.
//

import Foundation

final class CreateViewModel: ObservableObject {
    
    // Why we have not use private(set) because we actually
    // want the view to be able to make changes to this property
    // via a binding
    @Published var person = NewPerson()
    
    @Published private(set) var state: SubmissionState?
    
    func create() {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(person)
        
        NetworkingManager
            .shared
            .request(methodType: .POST(data: data), "https://reqres.in/api/users") { [weak self] res in
                // Result get from the service on to the main thread in UI
                DispatchQueue.main.async {
                    switch res {
                    case .success:
                        self?.state = .successful
                    case .failure(let err):
                        self?.state = .unsuccessful
                    }
                }
            }
    }
}

extension CreateViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
    }
}
