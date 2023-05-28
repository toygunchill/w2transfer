//
//  CommentListResponse.swift
//  algel
//
//  Created by Toygun Çil on 21.05.2023.
//

import Foundation

struct CommentListResponseElement: Codable {
    let id, userID, orderID, reviewersID: String?
    let comment, rating, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user-id"
        case orderID = "order-id"
        case reviewersID = "reviewers-id"
        case comment, rating
        case createdAt = "created-at"
    }
}

typealias CommentListResponse = [CommentListResponseElement]
