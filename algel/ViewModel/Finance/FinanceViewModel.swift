//
//  FinanceViewModel.swift
//  algel
//
//  Created by Toygun Çil on 22.05.2023.
//

import Foundation

class FinanceViewModel {
    func getFinanceList(completion: @escaping(FinanceListResponse) -> Void) {
        NetworkService.sharedNetwork.getFinanceList(userID: GlobalService.sharedGlobal.userID) { response in
            switch response {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
