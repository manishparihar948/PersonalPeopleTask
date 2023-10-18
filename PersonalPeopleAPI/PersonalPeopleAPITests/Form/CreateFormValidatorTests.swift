//
//  CreateFormValidatorTests.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 18.10.23.
//

import XCTest
@testable import PersonalPeopleAPI

final class CreateFormValidatorTests: XCTestCase {
    
    private var validator: CreateValidator! // ! Not symbol because its never going to be nil
    
    // Use of Setup before test case starts
    override func setUp() {
        validator = CreateValidator()
    }
    
    // Use of Tear Down allow to clear your system under test before each test is run
    override func tearDown() {
        validator = nil
    }

    func test_with_empty_person_first_name_error_thrown() {
        // lets create new empty person
        // The reason why we did not declare the person global we actually going to have a different type of person object everytime
        let person = NewPerson()
        // This throws error if something goes wrong
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty first name shsouldd be thrown")
        
        // do catch to capture an error
        do {
            _ = try validator.validate(person)
        } catch  {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_with_empty_first_name_error_thrown() {
        let person = NewPerson(lastName: "ads", job: "ios Dev")
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty first name shsouldd be thrown")

        // do catch to capture an error
        do {
            _ = try validator.validate(person)
        } catch  {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Expecting an error where we have an invalid first name")
        }

    }
    
    func test_with_empty_last_name_error_thrown() {
        let person = NewPerson(firstName: "Manish", job: "iOS Dev")
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty last name shsouldd be thrown")
        // do catch to capture an error
        do {
            _ = try validator.validate(person)
        } catch  {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidLastName, "Expecting an error where we have an invalid last name")
        }
    }
    
    func test_with_empty_job_error_thrown() {
        let person = NewPerson(firstName: "Manish", lastName: "Dev")
        
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty job shsouldd be thrown")
        // do catch to capture an error
        do {
            _ = try validator.validate(person)
        } catch  {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidJob, "Expecting an error where we have an invalid job name")
        }
    }
    
    func test_with_valid_person_error_not_thrown() {
        let person = NewPerson(firstName: "Manish", lastName: "Dev", job: "iOS Developer")

        do {
            _ = try validator.validate(person)
        } catch  {
                XCTFail("No errors should be thrown, since the person should be a valid object")
        }
    }

}
