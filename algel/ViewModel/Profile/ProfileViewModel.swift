//
//  ProfileViewModel.swift
//  algel
//
//  Created by Toygun Çil on 23.05.2023.
//

import Foundation

class ProfileViewModel {
    func getCommentList(userID: String?,
                        completion: @escaping (CommentListResponse) -> Void) {
        NetworkService.sharedNetwork.getCommentList(userID: userID) { response in
            switch response {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
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
