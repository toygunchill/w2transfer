//
//  HistoryViewController.swift
//  algel
//
//  Created by Toygun Çil on 4.05.2023.
//

import UIKit
import CoreLocation

class HistoryViewController: UIViewController {
    
    let viewModel = HistoryViewModel()
    
    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var historyCV: UICollectionView!
    @IBOutlet weak var historySearchBar: UISearchBar!
    
    var historyItems: [Int] = Array(1...10)
    
    var orderListHistoryArray: OrderListHistoryResponse? {
        didSet {
            historyCV.reloadData()
        }
    }
    
    var isFirst: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
        isFirst = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isFirst == false {
            setData()
        }
    }
    
    func setData() {
        viewModel.getOrderListHistory(userID: GlobalService.sharedGlobal.userID) { value in
            GlobalService.sharedGlobal.orderListHistory = value
            self.orderListHistoryArray = GlobalService.sharedGlobal.orderListHistory
        }
    }
    
    func setupUI() {
        configureBackgroundColor()
        
        categoryCV.delegate = self
        categoryCV.dataSource = self
        historyCV.delegate = self
        historyCV.dataSource = self
        historyCV.backgroundColor = .clear
        categoryCV.backgroundColor = .clear
        
        categoryCV.register(UINib(nibName: String(describing: CategoryCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CategoryCell.self))
        historyCV.register(UINib(nibName: String(describing: HistoryCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: HistoryCell.self))
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func convertWithGeocoder(value: OrderListHistoryResponse?,
                             indexPath: IndexPath,
                             completion: @escaping (String?, String?, String?, String?) -> Void) {
        if let latitudeString = value?[indexPath.item].latitude,
           let longitudeString = value?[indexPath.item].longitude {
            
            if let latitudeValue = Double(latitudeString),
               let longitudeValue = Double(longitudeString) {
                
                let location = CLLocation(latitude: latitudeValue, longitude: longitudeValue)
                let geocoder = CLGeocoder()
                
                geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                    if let error = error {
                        print("Reverse geocoding error: \(error.localizedDescription)")
                        completion(nil, nil, nil, nil)
                        return
                    }
                    
                    if let placemark = placemarks?.first {
                        // İl
                        let il = placemark.administrativeArea
                        
                        // İlçe
                        let ilce = placemark.locality
                        
                        // Mahalle
                        let mahalle = placemark.subLocality
                        
                        // Sokak
                        let sokak = placemark.thoroughfare
                        
                        completion(il, ilce, mahalle, sokak)
                    } else {
                        completion(nil, nil, nil, nil)
                    }
                }
            } else {
                completion(nil, nil, nil, nil)
            }
        }
    }
    
    func calculateDistanceBetweenCoordinates(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) -> CLLocationDistance {
        let location1 = CLLocation(latitude: latitude1, longitude: longitude1)
        let location2 = CLLocation(latitude: latitude2, longitude: longitude2)
        
        let distance = location1.distance(from: location2)
        
        return distance
    }
}

extension HistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == historyCV {
            return orderListHistoryArray?.count ?? 0
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == historyCV {
            guard let historyCell = historyCV.dequeueReusableCell(withReuseIdentifier: String(describing: HistoryCell.self), for: indexPath) as? HistoryCell else {
                return UICollectionViewCell()
            }
            historyCell.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 2, y: 2, blur: 10, spread: 0)
            convertWithGeocoder(value: orderListHistoryArray, indexPath: indexPath) { il, ilce, mahalle, sokak in
                if let il = il, let ilce = ilce, let mahalle = mahalle, let sokak = sokak {
                    historyCell.adressLabel.text = "\(il) \(ilce) \(mahalle) \(sokak)"
                }
            }
            return historyCell
        } else {
            guard let categoryCell = categoryCV.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCell.self), for: indexPath) as? CategoryCell else {
                return UICollectionViewCell()
            }
            categoryCell.layer.applySketchShadow(color: UIColor.black, alpha: 0.05, x: 0, y: 4, blur: 10, spread: 0)
            switch indexPath.row {
            case 0:
                categoryCell.categoryLabel.text = "Günlük"
            case 1:
                categoryCell.categoryLabel.text = "Haftalık"
            case 2:
                categoryCell.categoryLabel.text = "Aylık"
            default:
                print("error")
            }
            return categoryCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCV {
            if let categoryCell = categoryCV.cellForItem(at: indexPath) as? CategoryCell {
                categoryCell.categoryLabel.textColor = UIColor.red
            }
            switch indexPath.row {
            case 0:
                historyItems = Array(1...10)
            case 1:
                historyItems = Array(1...15)
            case 2:
                historyItems = Array(1...25)
            default:
                print("error")
            }
            historyCV.reloadData()
        } else {
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == categoryCV {
            if let categoryCell = categoryCV.cellForItem(at: indexPath) as? CategoryCell {
                categoryCell.categoryLabel.textColor = UIColor.black
            }
        } else {
            
        }
    }
}

extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCV {
            return CGSize(width: 70, height: 28)
        } else {
            return CGSize(width: 128, height: 128)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoryCV {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
}
