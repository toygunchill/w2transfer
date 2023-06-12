//
//  ActiveOrderViewModel.swift
//  algel
//
//  Created by Toygun Çil on 4.06.2023.
//

import Foundation

class ActiveOrderViewModel {
    func postDropCheck(orderID: String?,
                       transporterID: String?,
                       userID: String?,
                       completion: @escaping() -> Void) {
        NetworkService.sharedNetwork.postDropCheck(orderID: orderID,
                                                   transporterID: transporterID,
                                                   userID: userID) { response in
            switch response {
            case .success(let value):
                if let data = value.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let result = json.first?["result"] as? String {
                    print(result)
                    if result == "true" {
                        completion()
                    }
                } else {
                    print("Invalid response format")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
