//
//  UsersResponse.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//


import Foundation

// MARK: - UserResponse
// To avoid this error of : Global function 'XCTAssertEqual(_:_:_:file:line:)' requires that 'UsersResponse' conform to 'Equatable' on NetworkingMangerTests we need to add Equatable
struct UsersResponse: Codable, Equatable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}


