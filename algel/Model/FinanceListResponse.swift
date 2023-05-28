//
//  FinanceListResponse.swift
//  algel
//
//  Created by Toygun Çil on 21.05.2023.
//

import Foundation

// MARK: - FinanceListResponse
struct FinanceListResponse: Codable {
    let outgone, income: [Income]
}

// MARK: - Income
struct Income: Codable {
    let historyID, transporterID, startDate, endDate: String?
    let id, userID, pickupAdress, road: String
    let price, type, dropAdress: String

    enum CodingKeys: String, CodingKey {
        case historyID = "history-id"
        case transporterID = "transporter_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case id
        case userID = "user-id"
        case pickupAdress = "pickup_adress"
        case road, price, type
        case dropAdress = "drop-adress"
    }
}
