//
//  AddCommentViewModel.swift
//  algel
//
//  Created by Toygun Çil on 23.05.2023.
//

import Foundation

class AddCommentViewModel {
    func postComment(commentString: String,
                     ratingString: String,
                     completion: @escaping(String) -> Void) {
        NetworkService.sharedNetwork.postComment(userID: GlobalService.sharedGlobal.activeOrder?.userID,
                                                 orderID: GlobalService.sharedGlobal.activeOrder?.id,
                                                 reviewerID: GlobalService.sharedGlobal.userID,
                                                 commentString: commentString,
                                                 ratingString: ratingString) { response in
            switch response {
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
