//
//  CreateViewModelSuccessTests.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 20.10.23.
//

import XCTest
@testable import PersonalPeopleAPI

final class CreateViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var validationMock: CreateValidatorImpl!
    private var vm: CreateViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerCreateSuccessMock()
        validationMock = CreateValidatorSuccessMock()
        vm = CreateViewModel(networkingManager: networkingMock, validator: validationMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validationMock = nil
        vm = nil
    }
    
    func test_with_successful_response_submission_state_is_successful() async throws {
        
        // View model state is nil
        XCTAssertNil(vm.state, "The view model state should be nil initially")
        // Run at the end to validate the state is successful within the view model
        defer {
            XCTAssertEqual(vm.state, .successful, "The view model state should be successful")
        }
        await vm.create()
    }

}
