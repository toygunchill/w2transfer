//
//  HomeViewController.swift
//  algel
//
//  Created by Toygun Çil on 9.04.2023.
//

import UIKit
import MapKit
import CoreLocation
import MaterialComponents

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    
    @IBOutlet weak var activeMyOrderIV: UIImageView!
    @IBOutlet weak var exitIV: UIImageView!
    @IBOutlet weak var orderIV: UIImageView!
    @IBOutlet weak var createOrderBtn: UIImageView!
    @IBOutlet weak var centerBtnIV: UIImageView!
    @IBOutlet weak var ownerProductWightLbl: UILabel!
    @IBOutlet weak var ownerProductLocationLbl: UILabel!
    @IBOutlet weak var ownerProductOrderRoadLbl: UILabel!
    @IBOutlet weak var ownerProductNoteLbl: UILabel!
    @IBOutlet weak var ownerProductOrderOfferLbl: UILabel!
    @IBOutlet weak var ownerProductAcceptBtn: MDCButton!
    @IBOutlet weak var closeIconIV: UIImageView!
    @IBOutlet weak var ownerNameLbl: UILabel!
    @IBOutlet weak var ownerIV: UIImageView!
    @IBOutlet weak var ownerInfoView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    weak var createOrderViewController: CreateOrderViewController?
    var locationManager = CLLocationManager()
    var region : MKCoordinateRegion?
    var activeOrder: OrderListResponseElement? {
        didSet {
            GlobalService.sharedGlobal.activeOrder = activeOrder
        }
    }
    var activeMyOrder: OrderListTransportResponseElement? {
        didSet {
            GlobalService.sharedGlobal.activeMyOrder = activeMyOrder
        }
    }
    var activeCount: Int = 0 {
        didSet {
            orderIV.image = UIImage(systemName: "\(activeCount).lane")
            if activeCount == 0 {
                orderIV.isHidden = true
            } else {
                orderIV.isHidden = false
            }
        }
    }
    var activeMyOrderCount: Int = 0 {
        didSet {
            activeMyOrderIV.image = UIImage(systemName: "\(activeMyOrderCount).lane")
            if activeMyOrderCount == 0 {
                activeMyOrderIV.isHidden = true
            } else {
                activeMyOrderIV.isHidden = false
            }
        }
    }
    var orderList = GlobalService.sharedGlobal.orderList {
        didSet {
            orderList?.forEach({ order in
                pinAnnotation(order: order)
            })
        }
    }
    var orderListTransport = GlobalService.sharedGlobal.orderListTransport
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let setActive = self.activeCount
        self.activeCount = setActive
        let setMyActive = self .activeMyOrderCount
        self.activeMyOrderCount = setMyActive
        configureBackgroundColor()
        confiigureInfoView()
        visibleInfoView(visible: true)
        configureMapView()
        mapView.showsUserLocation = true
        let tapCenterGesture = UITapGestureRecognizer(target: self,
                                                      action: #selector(centerBtnIVTapped))
        configureTouchableIV(iv: centerBtnIV,
                             gestrue: tapCenterGesture)
        let tapCreateGesture = UITapGestureRecognizer(target: self,
                                                      action: #selector(createBtnIVTapped))
        configureTouchableIV(iv: createOrderBtn,
                             gestrue: tapCreateGesture)
        let tapOrderGesture = UITapGestureRecognizer(target: self,
                                                     action: #selector(orderBtnIVTapped))
        configureTouchableIV(iv: orderIV,
                             gestrue: tapOrderGesture)
        let tapOwnerIVGesture = UITapGestureRecognizer(target: self,
                                                       action: #selector(ownerIVTapped))
        configureTouchableIV(iv: ownerIV,
                             gestrue: tapOwnerIVGesture)
        let tapExitIVGesture = UITapGestureRecognizer(target: self,
                                                      action: #selector(exitIVTapped))
        configureTouchableIV(iv: exitIV,
                             gestrue: tapExitIVGesture)
        let tapActiveMyOderIVGesture = UITapGestureRecognizer(target: self,
                                                              action: #selector(activeMyOderIVTapped))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateOrderListTransport()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let checkedRegion = region {
            mapView.setRegion(checkedRegion, animated: true)
        }
        updateOrderList()
    }
    
    func updateOrderList() {
        viewModel.getOrderList(userID: GlobalService.sharedGlobal.userID) { value in
            GlobalService.sharedGlobal.orderList = value
            self.orderList = GlobalService.sharedGlobal.orderList
        }
    }
    
    func updateOrderListTransport() {
        viewModel.getOrderListTransport {
            self.activeMyOrder = GlobalService.sharedGlobal.orderListTransport?[0]
            self.activeMyOrderCount = self.orderListTransport?.count ?? 0
        }
    }
    
    func configureMapView(){
        DispatchQueue.main.async {
            self.mapView.delegate = self
            self.configureLocationManager()
        }
    }
    
    func configureLocationManager(){
        DispatchQueue.main.async {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func visibleInfoView(visible: Bool) {
        if visible == false {
            ownerInfoView.isHidden = false
        } else {
            ownerInfoView.isHidden = true
        }
    }
    
    func confiigureInfoView() {
        ownerInfoView.layer.cornerRadius = 16
        let tapCloeIV = UITapGestureRecognizer(target: self, action: #selector(cloeIVTapped))
        configureTouchableIV(iv: closeIconIV, gestrue: tapCloeIV)
        configureBTN(btn: ownerProductAcceptBtn,
                     title: "ACCEPT",
                     cornerRadius: 12,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        ownerInfoView.sizeThatFits(CGSize(width: self.view.frame.width - 36,
                                          height: 83 + ownerProductWightLbl.frame.height + ownerProductLocationLbl.frame.height + ownerProductOrderRoadLbl.frame.height + ownerProductOrderOfferLbl.frame.height + ownerProductNoteLbl.frame.height + ownerNameLbl.frame.height))
        ownerInfoView.backgroundColor = UIColor.white
        ownerInfoView.sizeToFit()
        ownerIV.sizeToFit()
        ownerNameLbl.sizeToFit()
        ownerProductWightLbl.sizeToFit()
        ownerProductLocationLbl.sizeToFit()
        ownerProductOrderRoadLbl.sizeToFit()
        ownerProductOrderOfferLbl.sizeToFit()
        ownerProductNoteLbl.sizeToFit()
        closeIconIV.sizeToFit()
        ownerInfoView.layer.applySketchShadow(color: UIColor.black,
                                              alpha: 0.1,
                                              x: 0, y: 4,
                                              blur: 10, spread: 0)
    }
    
    @objc func exitIVTapped() {
        DispatchQueue.main.async {
            UIApplication.restartApplication()
        }
    }
    
    @objc func centerBtnIVTapped() {
        if let checkedRegion = region {
            mapView.setRegion(checkedRegion, animated: true)
        }
    }
    
    @objc func cloeIVTapped() {
        ownerInfoView.isHidden = true
    }
    
    @objc func createBtnIVTapped() {
        if activeMyOrderCount == 0 {
            if let createVC = storyboard?.instantiateViewController(withIdentifier: "CreateOrderViewController") as? CreateOrderViewController {
                createVC.delegate = self
                self.navigationController?.pushViewController(createVC, animated: true)
            }
        } else {
            showError(message: "Yeni sipariş oluşturabilmek için önce aktif siparişinizi tamamlamalısınız")
        }
    }
    
    @objc func orderBtnIVTapped() {
        if let activeVC = storyboard?.instantiateViewController(withIdentifier: "ActiveOrderViewController") as? ActiveOrderViewController {
            if orderIV.image == UIImage(systemName: "1.lane") || activeCount == 0 {
                GlobalService.sharedGlobal.activeOrder = activeOrder
                self.navigationController?.pushViewController(activeVC, animated: true)
            }
        }
    }
    
    @objc func ownerIVTapped() {
        //burada other id al ve onu Globale gönder
        GlobalService.sharedGlobal.otherUserID = activeOrder?.userID
        if let otherVC = storyboard?.instantiateViewController(withIdentifier: "OtherProfileViewController") as? OtherProfileViewController {
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.pushViewController(otherVC, animated: true)
        }
    }
    
    @objc func activeMyOderIVTapped() {
        if let activeVC = storyboard?.instantiateViewController(withIdentifier: "ActiveOrderViewController") as? ActiveOrderViewController {
            if activeMyOrderIV.image == UIImage(systemName: "1.lane") || activeMyOrderCount == 0 {
                GlobalService.sharedGlobal.activeOrder = activeOrder
                self.navigationController?.pushViewController(activeVC, animated: true)
            }
        }
    }
    
    @IBAction func ownerProductAcceptBtnTapped(_ sender: Any) {
        if activeCount == 0 {
            activeCount += 1
            orderIV.image = UIImage(systemName: "\(activeCount).lane")
            viewModel.postTransportState(orderID: activeOrder?.id, transporterID: GlobalService.sharedGlobal.userID) {
                if let activeVC = self.storyboard?.instantiateViewController(withIdentifier: "ActiveOrderViewController") as? ActiveOrderViewController {
                    GlobalService.sharedGlobal.activeOrder = self.activeOrder
                    self.navigationController?.pushViewController(activeVC, animated: true)
                }
            }
        } else {
            showError(message: "Daha fazla sipariş alabilmek için önce aktif siparişlerinizi tamamlamanız gerekmektedir.")
        }
    }
    
    func showError(message: String) {
        let alertController = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

//    func setUserData(order: OrderListResponseElement,completion: @escaping() -> Void) {
//        self.viewModel.getUserDetail(userID: order.userID) { value in
//            let name = "\(value[0].name) \(value[0].surname)"
//            self.ownerNameLbl.text = name
//            if value[0].gender == "0" {
//                self.ownerIV.image = UIImage(named: "Users")
//            } else {
//                self.ownerIV.image = UIImage(named: "")
//            }
//            completion()
//        }
//    }
}

extension HomeViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        region = MKCoordinateRegion(center: location, span: span)
        
        orderList?.forEach({ order in
            pinAnnotation(order: order)
        })
        
        //MARK: - Burada rastgele sipariş oluşturduğum fonksiyonu çağırıyorum.
        //addRandomLocations(to: location)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation {
            let coordinateString = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
            orderList?.forEach({ order in
                if order.longitude == "\(annotation.coordinate.longitude)",
                   order.latitude == "\(annotation.coordinate.latitude)" {
                    activeOrder = order
                    self.viewModel.getUserDetail(userID: order.userID) { value in
                        let name = "\(value[0].name) \(value[0].surname)"
                        self.ownerNameLbl.text = name
                        if value[0].gender == "0" {
                            self.ownerIV.image = UIImage(named: "Users")
                        } else {
                            self.ownerIV.image = UIImage(named: "")
                        }
                        self.ownerProductOrderRoadLbl.text = "Road = \(order.road)"
                        self.ownerProductWightLbl.text = "Weight = \(order.type)"
                        self.ownerProductNoteLbl.text = "Note = \(order.note)"
                        self.ownerProductOrderOfferLbl.text = "Price = \(order.price)"
                        self.ownerProductLocationLbl.text = "Location = \(order.pickupAdress) --> \(order.dropAdress)"
                        self.visibleInfoView(visible: false)
                    }
                }
            })
        }
    }
}

extension HomeViewController: HomeViewControllerInterface {
    
    func setLocation() {
        guard let userLocation = locationManager.location else { return }
        let coordinateRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        GlobalService.sharedGlobal.userLocation = userLocation.coordinate
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = userLocation.coordinate
    }
    
    func addAnnotations() {
        guard let userLocation = locationManager.location else { return }
        let coordinateRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = userLocation.coordinate
        userAnnotation.title = "Buradayım"
        mapView.addAnnotation(userAnnotation)
    }
    
    func addRandomLocations(to center: CLLocationCoordinate2D) {
        let distance = 200.0 // 200 metre yakınlıkta konumlar belirlemek istiyoruz
        for _ in 1...5 { // 5 adet rastgele konum belirleyeceğiz
            let randomDistance = Double.random(in: 0..<distance)
            let randomAngle = Double.random(in: 0..<360)
            let latitude = center.latitude + (randomDistance * sin(randomAngle * Double.pi / 180)) / 111111
            let longitude = center.longitude + (randomDistance * cos(randomAngle * Double.pi / 180)) / (111111 * cos(center.latitude * Double.pi / 180))
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Sipariş"
            mapView.addAnnotation(annotation)
        }
    }
    
    func pinAnnotation(order: OrderListResponseElement) {
        if let lat = Double(order.latitude), let lon = Double(order.longitude) {
            let location = CLLocationCoordinate2D(latitude: lat,
                                                  longitude: lon)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = order.type
            mapView.addAnnotation(annotation)
        }
    }
}
