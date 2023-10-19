//
//  DetailsViewModelFailureTests.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 19.10.23.
//

import XCTest
@testable import PersonalPeopleAPI

final class DetailsViewModelFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var  vm: DetailViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserDetailsResponseFailureMock()
        vm = DetailViewModel(networkingManager: networkingMock)
    }

    override func tearDown() {
        networkingMock = nil
        vm = nil
    }
    
    func test_with_unsuccessful_response_error_is_handled() async {
        
        XCTAssertFalse(vm.isLoading, "The view model should not be loading")
        
        // At the end we make sure its not loading anymore
        defer {
            XCTAssertFalse(vm.isLoading, "The view model should not be loading")
        }
        
        await vm.fetchDetails(for: 1)
        
        XCTAssertTrue(vm.hasError, "This view model error should be true")
        
        XCTAssertNotNil(vm.error, "This view model error should not be nil")
    }
}
