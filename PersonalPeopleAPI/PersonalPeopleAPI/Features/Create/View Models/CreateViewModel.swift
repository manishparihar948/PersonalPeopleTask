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
    @Published private(set) var error: FormError?
    @Published var hasError = false
    
    // Create instance of createvalidator
    private let validator = CreateValidator()
    
    func create() {
        
        do {
            //after validate
            try validator.validate(person)
            
            // current state of data
            state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(person)
            
            NetworkingManager
                .shared
                .request(methodType: .POST(data: data), "https://reqres.in/api/users?delay=3") { [weak self] res in
                    // Result get from the service on to the main thread in UI
                    DispatchQueue.main.async {
                        switch res {
                        case .success:
                            self?.state = .successful
                        case .failure(let err):
                            self?.state = .unsuccessful
                            self?.hasError = true
                            if let networkingError = err as? NetworkingManager.NetworkingError {
                                self?.error = .networking(error: networkingError )
                            }
                        }
                    }
                }
            
        } catch {
            self.hasError = true
            if let validationError = error as? CreateValidator.CreateValidatorError {
                self.error = .validation(error: validationError)
            }
        }
    }
}

extension CreateViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
        case submitting
    }
}

extension CreateViewModel {
    enum FormError: LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
    }
}

// To check which type of error is in our view present, network type or validation type
extension CreateViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let err),
             .validation(let err):
            return err.errorDescription
        }
    }
}
