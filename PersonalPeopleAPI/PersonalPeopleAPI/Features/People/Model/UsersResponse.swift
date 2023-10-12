//
//  UsersResponse.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//


import Foundation

// MARK: - UserResponse
struct UsersResponse: Codable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}


