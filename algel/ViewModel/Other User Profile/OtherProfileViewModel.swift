//
//  OtherProfileViewModel.swift
//  algel
//
//  Created by Toygun Çil on 23.05.2023.
//

import Foundation

class OtherProfileViewModel {
    func getUserDetail(userID: String?,
                       completion: @escaping(UserDetailResponse) -> Void) {
        if let userID = userID {
            NetworkService.sharedNetwork.getUserDetail(userID: userID) { response in
                switch response {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
