//
//  HomeViewModel.swift
//  algel
//
//  Created by Toygun Çil on 21.05.2023.
//

import Foundation

class HomeViewModel {
    func getOrderList(userID: String?,
                      completion: @escaping(OrderListResponse) -> Void) {
        NetworkService.sharedNetwork.getOrderList(userID: userID) { response in
            switch response {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postTransportState(orderID: String?,
                            transporterID: String?,
                            completion: @escaping () -> Void) {
        NetworkService.sharedNetwork.postTransportState(orderID: orderID,
                                                        transporterID: transporterID) { response in
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
    
    func getOrderListTransport(completion: @escaping () -> Void) {
        NetworkService.sharedNetwork.getOrderListTransport(userID: GlobalService.sharedGlobal.userID) { response in
            switch response {
            case .success(let value):
                GlobalService.sharedGlobal.orderListTransport = value
                completion()
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
    
    //MARK: - Active = "2" transport
    //        Active = "0" history (tamamlandı)
    //        Active = "1" active
    //    func postOrderStateUpdate(orderID: String?, active: String?, completion: @escaping(String) -> Void) {
    //        NetworkService.sharedNetwork.postOrderStateUpdate(orderID: orderID, active: active) { response in
    //            switch response {
    //            case .success(let value):
    //                if let data = value.data(using: .utf8),
    //                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
    //                   let result = json.first?["result"] as? String {
    //                    print(result)
    //                    if result == "true"{
    //                        completion(result)
    //                    }
    //                } else {
    //                    print("Invalid response format")
    //                }
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //    }
    
}
