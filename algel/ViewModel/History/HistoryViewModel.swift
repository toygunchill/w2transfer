//
//  HistoryViewModel.swift
//  algel
//
//  Created by Toygun Çil on 4.06.2023.
//

import Foundation

class HistoryViewModel {
    func getOrderListHistory(userID: String?,
                             completion: @escaping(OrderListHistoryResponse) -> Void) {
        NetworkService.sharedNetwork.getOrderListHistory(userID: userID) { response in
            switch response {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
