//
//  RegisterViewModel.swift
//  algel
//
//  Created by Toygun Çil on 27.05.2023.
//

import Foundation

class RegisterViewModel {
    func postSignUp(password: String?,
                    phone: String?,
                    email: String?,
                    name: String?,
                    surname: String?,
                    gender: String?,
                    completion: @escaping(String) -> Void) {
        NetworkService.sharedNetwork.postSignUp(password: password, phone: phone, email: email, name: name, surname: surname, gender: gender) { response in
            switch response {
            case .success(let value):
                if let data = value.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let result = json.first?["result"] as? String {
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
