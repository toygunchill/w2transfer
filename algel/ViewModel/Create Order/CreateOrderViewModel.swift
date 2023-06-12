//
//  CreateOrderViewModel.swift
//  algel
//
//  Created by Toygun Çil on 23.05.2023.
//

import Foundation

class CreateOrderViewModel {
    func postCreateOrder(note: String,
                         pickup: String,
                         drop: String,
                         price: String,
                         latitude: String,
                         longitude: String,
                         type: String,
                         road: String,
                         completion: @escaping(String) -> Void) {
        NetworkService.sharedNetwork.postCreateOrder(userID: GlobalService.sharedGlobal.userID,
                                                     note: note,
                                                     pickup: pickup,
                                                     drop: drop,
                                                     price: price,
                                                     latitude: latitude,
                                                     longitude: longitude,
                                                     type: type,
                                                     road: road)
        { result in
            switch result {
            case .success(let value):
                if let data = value.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let result = json.first?["result"] as? String {
                    print(result)
                    completion(result)
                } else {
                    print("Invalid response format")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
