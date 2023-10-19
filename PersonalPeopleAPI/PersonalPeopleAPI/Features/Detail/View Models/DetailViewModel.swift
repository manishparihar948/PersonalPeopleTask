//
//  DetailViewModel.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 13.10.23.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserDetailResponse?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    /**
     For Integration Test
     Create a property for actually storing and holding for Integration Test
     */
    private let networkingManager: NetworkingManagerImpl!
    
    /**
     For Integration Test
     Creating constructor to  pass in a networking manager using the protocol implementation
     */
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }
    
    
    @MainActor
    func fetchDetails(for id: Int) async {
        isLoading = true
        defer { isLoading = false }
       
        do {
            // Edit based on networkingManager instead of NetworkingManager.shared
            self.userInfo = try await networkingManager.request(session: .shared ,
                                                                .detail(id: id),
                                                                type: UserDetailResponse.self)
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}
