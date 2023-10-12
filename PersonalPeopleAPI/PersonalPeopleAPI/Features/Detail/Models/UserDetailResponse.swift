//
//  UserDetailResponse.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//

import Foundation


// MARK: - UserDetailResponse
struct UserDetailResponse: Codable {
    let data: User
    let support: Support
}

