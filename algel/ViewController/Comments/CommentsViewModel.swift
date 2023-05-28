//
//  CommentsViewModel.swift
//  algel
//
//  Created by Toygun Çil on 23.05.2023.
//

import Foundation

class CommentsViewModel {
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
}
