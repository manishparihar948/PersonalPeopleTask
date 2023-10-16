//
//  PeopleViewModel.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 13.10.23.
//

import Foundation

final class PeopleViewModel: ObservableObject {
    
    // we want property to access from outside this class and we dont want to give someone the capability to actually change it from outside so you can only set it within the context of this classes scope
    @Published private(set) var users: [User] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    func fetchUsers() {
        isLoading = true
        NetworkingManager.shared.request(.people,
                                         type: UsersResponse.self) { [weak self] res in
            // Added DispatchQueue to call api data on background thread if we keep all the api call on main thread their might be chance of application may get crash which is inside the closure
            DispatchQueue.main.async {
                // use of defer - its going to make last statement that gets evaluated when everything else is finished so this ensures that we always call isLoading and set it to false
                defer { self?.isLoading = false }
                switch res {
                case .success(let response):
                    self?.users = response.data
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
            }
        }
    }
}
