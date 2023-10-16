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
    @Published var hasError = false
    
    func fetchUsers() {
        NetworkingManager.shared.request("https://reqres.in/api/users", 
                                         type: UsersResponse.self) { [weak self] res in
            // Added DispatchQueue to call api data on background thread if we keep all the api call on main thread their might be chance of application may get crash
            DispatchQueue.main.async {
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
