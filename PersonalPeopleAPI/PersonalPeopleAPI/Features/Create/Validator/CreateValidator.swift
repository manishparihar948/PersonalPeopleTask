//
//  CreateValidator.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 16.10.23.
//

import Foundation

/**
 Protocol Implementation created for Integration Testing
 */
protocol CreateValidatorImpl {
    // Use and get capabilities for and that is our validate function
    func validate(_ person: NewPerson) throws
}

/**
 Now conforn protocol here
 And we need to update our view model to accept our protocol for our validator and our networking manager so
 */
struct CreateValidator: CreateValidatorImpl {
    
    func validate(_ person: NewPerson) throws {
        if person.firstName.isEmpty {
            throw CreateValidatorError.invalidFirstName
        }
        
        if person.lastName.isEmpty {
            throw CreateValidatorError.invalidLastName
        }
        
        if person.job.isEmpty {
            throw CreateValidatorError.invalidJob
        }
    }
}

extension CreateValidator {
    enum CreateValidatorError: LocalizedError {
        case invalidFirstName
        case invalidLastName
        case invalidJob
    }
}

extension CreateValidator.CreateValidatorError {
    
    var errorDescription: String? {
        switch self {
        case .invalidFirstName:
            return "First name can't be empty"
        case .invalidLastName:
            return "Last name can't be empty"
        case .invalidJob:
            return "Job can't be empty"
        }
    }
}
