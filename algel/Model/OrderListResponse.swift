//
//  OrderListResponse.swift
//  algel
//
//  Created by Toygun Çil on 21.05.2023.
//

import Foundation

// MARK: - OrderListResponseElement
struct OrderListResponseElement: Codable {
    let id, userID, pickupAdress, road: String
    let price, type, latitude, longitude: String
    let pickupDate, dropAdress, createdAt, note: String
    let active: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user-id"
        case pickupAdress = "pickup-adress"
        case road, price, type, latitude, longitude
        case pickupDate = "pickup-date"
        case dropAdress = "drop-adress"
        case createdAt = "created-at"
        case note
        case active
    }
}

typealias OrderListResponse = [OrderListResponseElement]
