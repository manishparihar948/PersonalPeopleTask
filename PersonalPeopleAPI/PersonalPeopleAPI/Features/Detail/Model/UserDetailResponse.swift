//
//  UserDetailResponse.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//

import Foundation


// MARK: - UserDetailResponse
// Make Equatable for integration test
struct UserDetailResponse: Codable, Equatable {
    let data: User
    let support: Support
}

