//
//  PeopleViewModel.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 13.10.23.
//

import Foundation

// Wherever there is run time error shows due to background threads, we need to put the data back to main threads @MainActor automatically put everything on main thread
// There is two ways we can do it
// 1st - Make whole class @MainActor
// 2nd - Make individal funtion as @MainActor


final class PeopleViewModel: ObservableObject {
    
    // we want property to access from outside this class and we dont want to give someone the capability to actually change it from outside so you can only set it within the context of this classes scope
    @Published private(set) var users: [User] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    
    private var page = 1
    private var totalPages: Int?
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    @MainActor
    func fetchUsers() async {
        reset()
        // 1. Check loading is true when try and fetch a user
        viewState = .loading
        // 2. After finish setting is loaded to true, then write a defer to basically set loading back to false
        defer { viewState = .finished }
        // 3. Catch any errors thrown by our networking manager when we make our network request so we need do catch
        do {
        // 4. try & await the response that we get back from our networking manager
            /*
              What we are saying here we want to try to fetch the users response from the users endpoint and
              we are going to await the values so its worth nothing here that we specified the endpoint
             */
            let response = try await NetworkingManager.shared.request(.people(page: page), type: UsersResponse.self)
            
            self.totalPages = response.totalPages
        // 5. our users array to the value within our response.data
            self.users = response.data
        } catch {
        // 6. Handle the error
            self.hasError = true
        // 7. Specify type of error
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    // Create a new function for fetching next set of users
    @MainActor
    func fetchNextSetOfUsers() async {
        
        guard page != totalPages else { return }
        
        viewState = .fetching
        defer { viewState = .finished }

        page += 1
        
        do {
            let response = try await NetworkingManager.shared.request(.people(page: page), type: UsersResponse.self)
            self.totalPages = response.totalPages
            self.users += response.data // replacing whole array
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    // for next page call
    func hasReachedEnd(of user:User) -> Bool {
        /*
        // Check in the function - If the last user or object in the array matches the
        // current user thats been passed into this function in order to write this statement
         */
        users.last?.id == user.id
        
    }
}

extension PeopleViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

// Reset Page
private extension PeopleViewModel {
    func reset() {
        if viewState == .finished {
            users.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}
