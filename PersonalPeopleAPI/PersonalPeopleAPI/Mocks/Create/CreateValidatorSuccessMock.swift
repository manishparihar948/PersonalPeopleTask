//
//  CreateValidatorSuccessMock.swift
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
//@testable import PersonalPeopleAPI

struct CreateValidatorSuccessMock: CreateValidatorImpl  {
    /*
     This function does not return anything and we dont want actualy to do nothing,
     because this is success so we dont want to throw any errors we want to simulates as if
     everything is ok
     */
    func validate(_ person: PersonalPeopleAPI.NewPerson) throws {}
    
    
}

#endif
