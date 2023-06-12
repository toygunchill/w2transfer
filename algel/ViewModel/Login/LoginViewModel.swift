//
//  LoginViewModel.swift
//  algel
//
//  Created by Toygun Çil on 21.05.2023.
//

import UIKit

class LoginViewModel {
    
    func postSignIn(password: String,
                    phone: String,
                    completion: @escaping() -> Void) {
        NetworkService.sharedNetwork.postSignIn(password: password, phone: phone) { response in
            switch response {
            case .success(let value):
                if let data = value.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let result = json.first?["result"] as? String {
                    print(result)
                    if result == "true",
                       let id = json.first?["id"] as? String {
                        GlobalService.sharedGlobal.userID = id
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
