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
    
    // Create another constant for our networking manager
    private let networkingManager: NetworkingManagerImpl!
    // Create constant of createvalidator
    private let validator: CreateValidatorImpl!
  
    
    /* 
     First of all we call initializer and we can pass in any object in
     that conforms to this protocol
     And when we write our integration test - we going to use instance of our 
     networking manager default "NetworkingManager.shared"  and also we going 
     to use create validator as a default as well "CreateValidator()"
     */
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared ,
         validator: CreateValidatorImpl = CreateValidator()) {
        self.networkingManager = networkingManager
        self.validator = validator
    }
    
    @MainActor
    func create() async {
        
        // 1.  Validation to validate
        do {
            try validator.validate(person)
        // 2. state telling view that we are submitting some data
            state = .submitting
        // 3. Encode the data someone has input inthe form into some kind of data that we can send within our network request
            let encoder = JSONEncoder()
        // 4. JSONN Encoder help to convert our new person from some codable to some data so we can associate this with the api request that we send to the service
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(person)
        // 5. Try to send the data, we dont want function where it actually tries to decode some kind of object when you make a network request instead of that we use alternative function we have in our network manager class that simple execute the request and froze an error if something goes wrong so
            try await networkingManager.request(session: .shared, .create(submissionData: data))
        // 6. finally set the state to be successful
            state = .successful
            
        } catch  {
        // 7. Handling error if anything goes wrong
            self.hasError = true
            self.state = .unsuccessful

        // 8.  Switch on the error and type of error
            switch error {
            case is NetworkingManager.NetworkingError:
                self.error = .networking(error: error as! NetworkingManager.NetworkingError)
            case is CreateValidator.CreateValidatorError:
                self.error = .validation(error: error as! CreateValidator.CreateValidatorError)
            default:
                self.error = .system(error: error)
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
        case system(error: Error)
    }
}

// To check which type of error is in our view present, network type or validation type
extension CreateViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let err),
             .validation(let err):
            return err.errorDescription
        case .system(let err):
            return err.localizedDescription
        }
    }
}

// For integration Testing
extension CreateViewModel.FormError: Equatable {
    static func == (lhs: CreateViewModel.FormError, rhs: CreateViewModel.FormError) -> Bool {
        switch (lhs, rhs) {
        case (.networking(let lhsType), .networking(let  rhsType)):
            return lhsType.errorDescription == rhsType.errorDescription
        case (.validation(let lhsType), .validation(let  rhsType)):
            return lhsType.errorDescription == rhsType.errorDescription
        case (.system(let lhsType), .system(let  rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default :
            return false
        }
    }
}
