//
//  NetworkService.swift
//  algel
//
//  Created by Toygun Çil on 14.05.2023.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let sharedNetwork = NetworkService()
    
    func postSignIn(password: String?,
                    phone: String?,
                    completion: @escaping(Result<String, AFError>) -> Void)  {
        if let pass = password,
           let phn = phone {
            let parameters: [String: Any] = [
                "phone": phn,
                "pass": pass
            ]
            
            let url = "https://kouiot.com/toygun/signin.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseString { response in
                completion(response.result)
            }
        }
    }
    
    func postSignUp(password: String?,
                    phone: String?,
                    email: String?,
                    name: String?,
                    surname: String?,
                    gender: String?,
                    completion: @escaping(Result<String,AFError>) -> Void) {
        if let pass = password,
           let phn = phone,
           let eml = email,
           let name = name,
           let surname = surname,
           let gender = gender {
            let parameters: [String: Any] = [
                "phone": phn,
                "pass": pass,
                "name": name,
                "surname": surname,
                "gender": gender,
                "mail": eml
            ]
            
            let url = "https://kouiot.com/toygun/signup.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseString { response in
                completion(response.result)
            }
        }
    }
    
    func postCreateOrder(userID: String?,
                         note: String?,
                         pickup: String?,
                         drop: String?,
                         price: String?,
                         latitude: String?,
                         longitude: String?,
                         type: String?,
                         road: String?,
                         completion: @escaping(Result<String,AFError>) -> Void) {
        if let usrId = userID,
           let nt = note,
           let pckup = pickup,
           let drp = drop,
           let prce = price,
           let lttde = latitude,
           let lngttde = longitude,
           let type = type {
            let parameters: [String: Any] = [
                "user-id": usrId,
                "note": nt,
                "pickup": pckup,
                "drop": drp,
                "price": prce,
                "latitude": lttde,
                "longitude": lngttde,
                "type": type
            ]
            
            let url = "https://kouiot.com/toygun/order-create.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseString { response in
                completion(response.result)
            }
        }
    }
    
    func postComment(userID: String?,
                     orderID: String?,
                     reviewerID: String?,
                     commentString: String?,
                     ratingString: String?,
                     completion: @escaping(Result<String,AFError>) -> Void) {
        if let userID = userID,
           let orderID = orderID,
           let reviewerID = reviewerID,
           let commentString = commentString,
           let ratingString = ratingString {
            let parameters: [String: Any] = [
                "user-id": userID,
                "order-id": orderID,
                "reviewer-id": reviewerID,
                "comment": commentString,
                "rating": ratingString
            ]
            let url = "https://kouiot.com/toygun/user-comment.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers).responseString { response in
                completion(response.result)
            }
        }
    }
    
    func getCommentList(userID: String?, completion: @escaping(Result<CommentListResponse,AFError>) -> Void) {
        if let userID = userID {
            let parameters: [String: Any] = [
                "user-id": userID
            ]
            let url = "https://kouiot.com/toygun/user-comment-list.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let value = try JSONDecoder().decode(CommentListResponse.self, from: data)
                        completion(.success(value))
                    } catch {
                        completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getFinanceList(userID: String?, completion: @escaping(Result<FinanceListResponse,AFError>) -> Void) {
        if let userID = userID {
            let parameters: [String: Any] = [
                "user-id": userID
            ]
            let url = "https://kouiot.com/toygun/finance.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let value = try JSONDecoder().decode(FinanceListResponse.self, from: data)
                        completion(.success(value))
                    } catch {
                        completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getOrderListActive(userID: String?, completion: @escaping(Result<OrderListActiveResponse,AFError>) -> Void) {
        if let userID = userID {
            let parameters: [String: Any] = [
                "user-id": userID
            ]
            let url = "https://kouiot.com/toygun/user-order-list-active.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let value = try JSONDecoder().decode(OrderListActiveResponse.self, from: data)
                        completion(.success(value))
                    } catch {
                        completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getOrderListTransport(userID: String?, completion: @escaping(Result<OrderListTransportResponse,AFError>) -> Void) {
        if let userID = userID {
            let parameters: [String: Any] = [
                "user-id": userID
            ]
            let url = "https://kouiot.com/toygun/user-order-list-transport.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let value = try JSONDecoder().decode(OrderListTransportResponse.self, from: data)
                        completion(.success(value))
                    } catch {
                        completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getOrderListHistory(userID: String?, completion: @escaping(Result<OrderListHistoryResponse,AFError>) -> Void) {
        if let userID = userID {
            let parameters: [String: Any] = [
                "user-id": userID
            ]
            let url = "https://kouiot.com/toygun/user-order-list-history.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let value = try JSONDecoder().decode(OrderListHistoryResponse.self, from: data)
                        completion(.success(value))
                    } catch {
                        completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    //MARK: - HomeViewController.swift
    func getOrderList(userID: String?, completion: @escaping(Result<OrderListResponse,AFError>) -> Void) {
        if let userID = userID {
            let parameters: [String: Any] = [
                "user-id": userID
            ]
            let url = "https://kouiot.com/toygun/order-list.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let value = try JSONDecoder().decode(OrderListResponse.self, from: data)
                        completion(.success(value))
                    } catch {
                        completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    //MARK: - All VC Order State Update
    
    func postOrderStateUpdate(orderID: String?,
                              active: String?, completion: @escaping(Result<String,AFError>) -> Void) {
        if let orderID = orderID,
           let active = active {
            let parameters: [String: Any] = [
                "order-id": orderID,
                "active": active
            ]
            
            let url = "https://kouiot.com/toygun/order-state-set.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseString { response in
                completion(response.result)
            }
        }
    }

}
