//
//  Models.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//

import Foundation

// MARK: - User
struct User: Codable, Equatable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}

// MARK: - Support
struct Support: Codable, Equatable {
    let url: String
    let text: String
}
