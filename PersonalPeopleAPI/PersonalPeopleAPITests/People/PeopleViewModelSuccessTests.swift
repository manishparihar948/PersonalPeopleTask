//
//  PeopleViewModelSuccessTests.swift
//  PersonalPeopleAPITests
//
//  Created by Manish Parihar on 19.10.23.
//

import XCTest
@testable import PersonalPeopleAPI

final class PeopleViewModelSuccessTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerImpl!
    private var vm: PeopleViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserResponseSuccessMock()
        vm = PeopleViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }

    /**
     This test is going to see if we actually get a successful response back from our service is our user array set,
     before we going to write our test, we need to write mock for our network manager,
     With our protocol, we need to create our fake network manager that will always just kind of stop and return some data to us.
     so essentially we want to mock a successful object coming back, so in our networking folder lets create a mock for the
     networking manager user response success
     */
    func test_with_successful_response_users_array_is_set() async throws {
        // Before loading users, false
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        defer {
            // After loading users, false
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
            
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        await vm.fetchUsers()
        XCTAssertEqual(vm.users.count,6, "There should be 6 users within our data array")
    }
    
    func test_with_successful_paginated_response_users_array_is_set() async throws {
        // 1st test if view model is not loading
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        
        defer {
            // After fetching users, false
            XCTAssertFalse(vm.isFetching, "The view model shouldn't be fetching any data")
            
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        
        // fetch first batch of array from page 1
        await vm.fetchUsers()
        
        // Test
        XCTAssertEqual(vm.users.count, 6, "There should be 6 users within our data array")
        
        // Fetch next batch of array from next page
        await vm.fetchNextSetOfUsers()
        
        // Test
        XCTAssertEqual(vm.users.count, 12, "There should be 12 users within our data array")
        
        XCTAssertEqual(vm.page, 2, "The page should be 2")
    }
    
    // Check reset test when we do refresh from people view refresh button
    func test_with_reset_called_values_is_reset() async throws {
        
        defer {
            XCTAssertEqual(vm.users.count, 6, "There should be 6 users within our data array")
            XCTAssertEqual(vm.page, 1, "The page should be 1")
            XCTAssertEqual(vm.totalPages, 2, "The total pages is 2")
            XCTAssertEqual(vm.viewState, .finished, "The view  model view state should be finished")
            XCTAssertFalse(vm.isLoading, "The view model should not be loading any data")
        }
        // first Fetch users
        await vm.fetchUsers()
        
        // Test
        XCTAssertEqual(vm.users.count, 6, "There should be 6 users within our data array")
        
        // Fetch next page users
        await vm.fetchNextSetOfUsers()
        
        // Test
        XCTAssertEqual(vm.users.count, 12, "There should be 12 users within our data array")
        
        XCTAssertEqual(vm.page, 2, "The page should be 2")
        
        // Reset -  user list set the value again
        await vm.fetchUsers()
    }
    
    // Check if the functionn reached the end of the api data last user end to the function.
    func test_with_last_user_func_returns_true() async {
        await vm.fetchUsers()
        
        let userData = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        
        let hasReachedEnd = vm.hasReachedEnd(of: userData.data.last!)
        
        XCTAssertTrue(hasReachedEnd, "The last user should match")
    }
}
