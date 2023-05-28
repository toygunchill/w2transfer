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
    
    var userID: String? = ""
    var userLocation: CLLocationCoordinate2D?
    
    var orderListHistory: OrderListHistoryResponse?
    var orderList: OrderListResponse? //Homeviewcontroller.swift içi dolacak
    var financeList: FinanceListResponse? //FinanceViewController.swift içi dolacak
    var activeOrder: OrderListResponseElement? //Home'da butona tıklayınca doluyor sıradaki ekranlarda kullanıyorum
}
