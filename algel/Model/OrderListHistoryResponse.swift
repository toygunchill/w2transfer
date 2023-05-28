//
//  OrderListHistoryResponse.swift
//  algel
//
//  Created by Toygun Çil on 21.05.2023.
//

import Foundation

// MARK: - OrderListHistoryResponseElement
struct OrderListHistoryResponseElement: Codable {
    let id, userID, pickupAdress, road: String?
    let price, type, latitude, longitude: String?
    let pickupDate, dropAdress, createdAt, note: String?
    let active, historyID, transporterID, startDate: String?
    let endDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user-id"
        case pickupAdress = "pickup_adress"
        case road, price, type, latitude, longitude
        case pickupDate = "pickup-date"
        case dropAdress = "drop-adress"
        case createdAt = "created-at"
        case note, active
        case historyID = "history-id"
        case transporterID = "transporter_id"
        case startDate = "start_date"
        case endDate = "end_date"
    }
}

typealias OrderListHistoryResponse = [OrderListHistoryResponseElement]
