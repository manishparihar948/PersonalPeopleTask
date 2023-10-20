//
//  CreateValidatorFailureMock.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 20.10.23.
//

#if DEBUG
import Foundation

/**
 Because of making global use of this testing class we need to Change Target Membership
 And comment @testable import PersonalPeopleAPI
 */
// Then add testable project
// @testable import PersonalPeopleAPI

struct CreateValidatorFailureMock: CreateValidatorImpl  {
    /*
     Mock for invalid form
     Throw a invalid validator
     */
    func validate(_ person: PersonalPeopleAPI.NewPerson) throws {
        throw CreateValidator.CreateValidatorError.invalidFirstName
    }
}

#endif
