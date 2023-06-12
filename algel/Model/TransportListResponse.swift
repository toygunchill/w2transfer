//
//  TransportListResponse.swift
//  algel
//
//  Created by Toygun Çil on 4.06.2023.
//

import Foundation

struct TransportListResponseElement: Codable {
    let id, transporterID: String

    enum CodingKeys: String, CodingKey {
        case id
        case transporterID = "transporter-id"
    }
}

typealias TransportListResponse = [TransportListResponseElement]
