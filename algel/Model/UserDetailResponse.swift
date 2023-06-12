//
//  UserDetailResponse.swift
//  algel
//
//  Created by Toygun Çil on 12.06.2023.
//

import Foundation

// MARK: - UserDetailResponseElement
struct UserDetailResponseElement: Codable {
    let name, surname, email, gender: String
    let phoneNumber, createdAt: String

    enum CodingKeys: String, CodingKey {
        case name, surname, email, gender
        case phoneNumber = "phone-number"
        case createdAt = "created-at"
    }
}

typealias UserDetailResponse = [UserDetailResponseElement]
