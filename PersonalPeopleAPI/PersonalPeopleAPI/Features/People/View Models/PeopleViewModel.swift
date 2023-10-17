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
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    @MainActor
    func fetchUsers() async {
        // 1. Check loading is true when try and fetch a user
        isLoading = true
        // 2. After finish setting is loaded to true, then write a defer to basically set loading back to false
        defer { isLoading = false }
        // 3. Catch any errors thrown by our networking manager when we make our network request so we need do catch
        do {
        // 4. try & await the response that we get back from our networking manager
            /*
              What we are saying here we want to try to fetch the users response from the users endpoint and
              we are going to await the values so its worth nothing here that we specified the endpoint
             */
            let response = try await NetworkingManager.shared.request(.people, type: UsersResponse.self)
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
}
