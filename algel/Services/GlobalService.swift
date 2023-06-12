//
//  GlobalService.swift
//  algel
//
//  Created by Toygun Çil on 14.05.2023.
//

import Foundation
import CoreLocation

class GlobalService {
    static let sharedGlobal = GlobalService()
    
    var otherUserID: String? = ""
    
    var userID: String? = ""
    var userPhone: String? = ""
    var userEmail: String? = ""
    var userName: String? = ""
    var userSurname: String? = ""
    var userGender: String? = ""
    
    var userLocation: CLLocationCoordinate2D?
    
    var orderListHistory: OrderListHistoryResponse?
    var orderListTransport: OrderListTransportResponse?
    var orderList: OrderListResponse? //Homeviewcontroller.swift içi dolacak
    var financeList: FinanceListResponse? //FinanceViewController.swift içi dolacak
    
    var activeOrder: OrderListResponseElement? //Home'da butona tıklayınca doluyor sıradaki ekranlarda kullanıyorum
    var activeMyOrder: OrderListTransportResponseElement? //Home'da doluyor sıradaki ekranlarda kullanıyorum
}
