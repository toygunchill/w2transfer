//
//  CreateOrderViewController.swift
//  algel
//
//  Created by Toygun Çil on 7.05.2023.
//

import UIKit
import MaterialComponents
import Lottie
import Alamofire
import CoreLocation
import DropDown

protocol HomeViewControllerInterface {
    func addAnnotations()
    func setLocation()
    func updateOrderList()
}

class CreateOrderViewController: UIViewController {

    let viewModel =  CreateOrderViewModel()

    @IBOutlet weak var infoIV: UIImageView!
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var selectWeightLBtn: UIButton!
    @IBOutlet weak var selectWeightMBtn: UIButton!
    @IBOutlet weak var selectWeightSBtn: UIButton!
    @IBOutlet weak var selectWeightSubLbl: UILabel!
    @IBOutlet weak var selectWeightLbl: UILabel!
    @IBOutlet weak var selectWeightBackgroundView: UIView!
    @IBOutlet weak var finalOfferBackgroundView: UIView!
    @IBOutlet weak var offerTF: MDCOutlinedTextField!
    @IBOutlet weak var cityDropBtn: UIButton!
    @IBOutlet weak var districtDropBtn: UIButton!
    @IBOutlet weak var neighborhoodDropBtn: UIButton!
    @IBOutlet weak var streetDropBtn: UIButton!
    @IBOutlet weak var finalOfferLbl: UILabel!
    @IBOutlet weak var finalOfferSubLbl: UILabel!
    @IBOutlet weak var finalOfferSepView: UIView!
    @IBOutlet weak var finalOfferAmountLbl: UILabel!
    
    @IBOutlet weak var noteTF: MDCOutlinedTextField!
    
    @IBOutlet weak var offerBtn: MDCButton!
    
    
    var delegate: HomeViewControllerInterface?
    
    var selectedWeight: String? = "Medium"
    var selectedCity: String?
    var selectedDistrict: String?
    var selectedNeighborhood: String?
    var selectedStreet: String?
    
    
    let cityDropDown = DropDown()
    let districtDropDown = DropDown()
    let neighborhoodDropDown = DropDown()
    let streetDropDown = DropDown()
    
    let cities = ["Kocaeli", "İstanbul"]
    let districts = ["Kocaeli": ["İzmit", "Gebze"], "İstanbul": ["Kadıköy", "Beşiktaş"]]
    let neighborhoods = ["İzmit": ["İzmit Mahallesi", "Gebze Mahallesi"], "Gebze": ["Çayırova Mahallesi", "Darıca Mahallesi"], "Kadıköy": ["Moda Mahallesi", "Kozyatağı Mahallesi"], "Beşiktaş": ["Levent Mahallesi", "Ortaköy Mahallesi"]]
    let streets = ["İzmit Mahallesi": ["Atatürk Caddesi", "Cumhuriyet Sokak"], "Gebze Mahallesi": ["İstasyon Caddesi", "Bahçelievler Sokak"], "Çayırova Mahallesi": ["Anıt Caddesi", "Yeni Sokak"], "Darıca Mahallesi": ["Sahil Caddesi", "Yalı Sokak"], "Moda Mahallesi": ["Caferağa Sokak", "Bahariye Caddesi"], "Kozyatağı Mahallesi": ["Bağdat Caddesi", "Fikirtepe Sokak"], "Levent Mahallesi": ["Esentepe Caddesi", "Levent Caddesi"], "Ortaköy Mahallesi": ["Mecidiye Caddesi", "Bebek Sokak"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationController?.isNavigationBarHidden = false
        offerTF.delegate = self
        offerTF.keyboardType = .numberPad
        configureBackgroundColor()
        
        if selectedWeight == "Medium" {
            selectWeightLBtn.tintColor = UIColor.black
            selectWeightMBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
            selectWeightSBtn.tintColor = UIColor.black
        } else if selectedWeight == "Large" {
            selectWeightLBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
            selectWeightMBtn.tintColor = UIColor.black
            selectWeightSBtn.tintColor = UIColor.black
        } else {
            selectWeightLBtn.tintColor = UIColor.black
            selectWeightMBtn.tintColor = UIColor.black
            selectWeightSBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
        }
        
        finalOfferBackgroundView.layer.cornerRadius = 12
        finalOfferBackgroundView.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
        finalOfferBackgroundView.backgroundColor = UIColor.white
        
        lottieView.layer.cornerRadius = 12
        lottieView.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
        
        infoIV.layer.cornerRadius = 12

        
        
        selectWeightBackgroundView.layer.cornerRadius = 12
        selectWeightBackgroundView.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
        selectWeightBackgroundView.backgroundColor = UIColor.white
        
        offerBtn.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
        offerTF.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
        noteTF.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
        cityDropBtn.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
        districtDropBtn.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
        neighborhoodDropBtn.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
        streetDropBtn.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
        

        
        configureBTN(btn: offerBtn,
                     title: "OFFER",
                     cornerRadius: 12,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        configureOTF(tf: offerTF,
                    text: "What is your offer?",
                    placeholder: "",
                    normalColor: UIColor.black,
                    editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        configureOTF(tf: noteTF,
                    text: "Taşıyıcıya Notunuz",
                    placeholder: "",
                    normalColor: UIColor.black,
                    editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        setDropDown()
    }
    
    func setDropDown() {
        // Şehir Dropdown listesi ayarları
        cityDropDown.anchorView = cityDropBtn
        cityDropDown.dataSource = cities
        
        cityDropBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
        districtDropBtn.tintColor = .black
        neighborhoodDropBtn.tintColor = .black
        streetDropBtn.tintColor = .black
        
        cityDropBtn.layer.cornerRadius = 12
        districtDropBtn.layer.cornerRadius = 12
        neighborhoodDropBtn.layer.cornerRadius = 12
        streetDropBtn.layer.cornerRadius = 12
        
        cityDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            cityDropBtn.setTitle(item, for: .normal)
            selectedCity = item
            // İlçe Dropdown listesini güncelle
            cityDropBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
            districtDropBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
            neighborhoodDropBtn.tintColor = .black
            streetDropBtn.tintColor = .black
            updateDistricts(for: item)
            // İlçe ve alt seviyelerin butonlarını temizle
            districtDropBtn.setTitle("İlçe Seçiniz", for: .normal)
            neighborhoodDropBtn.setTitle("Mahalle Seçiniz", for: .normal)
            streetDropBtn.setTitle("Sokak Seçiniz", for: .normal)
        }
        
        // İlçe Dropdown listesi ayarları
        districtDropDown.anchorView = districtDropBtn
        districtDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            districtDropBtn.setTitle(item, for: .normal)
            selectedDistrict = item
            // Mahalle Dropdown listesini güncelle
            districtDropBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
            neighborhoodDropBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
            streetDropBtn.tintColor = .black
            updateNeighborhoods(for: item)
            // Mahalle ve alt seviyelerin butonlarını temizle
            neighborhoodDropBtn.setTitle("Mahalle Seçiniz", for: .normal)
            streetDropBtn.setTitle("Sokak Seçiniz", for: .normal)
        }
        
        // Mahalle Dropdown listesi ayarları
        neighborhoodDropDown.anchorView = neighborhoodDropBtn
        neighborhoodDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            neighborhoodDropBtn.setTitle(item, for: .normal)
            selectedNeighborhood = item
            // Sokak Dropdown listesini güncelle
            neighborhoodDropBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
            streetDropBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
            updateStreets(for: item)
            // Sokak butonunu temizle
            streetDropBtn.setTitle("Sokak Seçiniz", for: .normal)
        }
        
        // Sokak Dropdown listesi ayarları
        streetDropDown.anchorView = streetDropBtn
        streetDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            streetDropBtn.setTitle(item, for: .normal)
            streetDropBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
            selectedStreet = item
        }
    }
    
    // İlçe dropdown listesini güncelleme fonksiyonu
    func updateDistricts(for city: String) {
        guard let districts = districts[city] else { return }
        districtDropDown.dataSource = districts
    }
    
    // Mahalle dropdown listesini güncelleme fonksiyonu
    func updateNeighborhoods(for district: String) {
        guard let neighborhoods = neighborhoods[district] else { return }
        neighborhoodDropDown.dataSource = neighborhoods
    }
    
    // Sokak dropdown listesini güncelleme fonksiyonu
    func updateStreets(for neighborhood: String) {
        guard let streets = streets[neighborhood] else { return }
        streetDropDown.dataSource = streets
    }
    

    @IBAction func selectWeightLargeBtnTapped(_ sender: Any) {
        selectedWeight = "Large"
        selectWeightLBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
        selectWeightSBtn.tintColor = UIColor.black
        selectWeightMBtn.tintColor = UIColor.black
    }
    @IBAction func selectWeightMediumBtnTapped(_ sender: Any) {
        selectedWeight = "Medium"
        selectWeightMBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
        selectWeightLBtn.tintColor = UIColor.black
        selectWeightSBtn.tintColor = UIColor.black
    }
    @IBAction func selectWeightSmallBtnTapped(_ sender: Any) {
        selectedWeight = "Small"
        selectWeightSBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
        selectWeightLBtn.tintColor = UIColor.black
        selectWeightMBtn.tintColor = UIColor.black
    }
    
    @IBAction func cityDropBtnTapped(_ sender: Any) {
        cityDropDown.show()
    }

    @IBAction func districtDropBtnTapped(_ sender: Any) {
        districtDropDown.show()
    }
    
    @IBAction func neighborhoodDropBtnTapped(_ sender: Any) {
        neighborhoodDropDown.show()
    }
    
    @IBAction func streetDropBtnTapped(_ sender: Any) {
        streetDropDown.show()
    }
    
    @IBAction func createBtnTapped(_ sender: Any) {
        //delegate?.addAnnotations()
        delegate?.setLocation()
        if let userLocation = GlobalService.sharedGlobal.userLocation {
            let latitude = String(describing: userLocation.latitude)
            let longitude = String(describing: userLocation.longitude)
            
            convertWithGeocoder(latitude: latitude, longitude: longitude) { il, ilce, mahalle, sokak in
                if let il = il,
                   let ilce = ilce,
                   let mahalle = mahalle,
                   let sokak = sokak,
                   let selectedWeight = self.selectedWeight,
                   let note = self.noteTF.text,
                   let drop = self.selectedWeight,
                   let price = self.offerTF.text{
                    if let ilDropString = self.selectedCity,
                       let ilceDropString = self.selectedDistrict,
                       let mahalleDropString = self.selectedNeighborhood,
                       let sokakDropString = self.selectedStreet {
                        self.convertAddressToCoordinates(il: ilDropString, ilce: ilceDropString, mahalle: mahalleDropString, sokak: sokakDropString) { latDrop, lonDrop in
                            if let lat1 = Double(latitude),
                               let lon1 = Double(longitude),
                               let lat2 = latDrop,
                               let lon2 = lonDrop {
                                let distanceRoad = self.calculateDistanceBetweenCoordinates(latitude1: lat1,
                                                                                            longitude1: lon1,
                                                                                            latitude2: lat2,
                                                                                            longitude2: lon2)
                                self.viewModel.postCreateOrder(note: note,
                                                               pickup: "\(il) - \(ilce) - \(mahalle) - \(sokak)",
                                                               drop: "\(ilDropString) - \(ilceDropString) - \(mahalleDropString) - \(sokakDropString)",
                                                               price: price,
                                                               latitude: latitude,
                                                               longitude: longitude,
                                                               type: selectedWeight,
                                                               road: String(distanceRoad)) { result in
                                    if result == "true"{
                                        self.navigationController?.popToRootViewController(animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        delegate?.updateOrderList()
    }
    
    
    
    func convertWithGeocoder(latitude: String?,
                             longitude: String?,
                             completion: @escaping (String?, String?, String?, String?) -> Void) {
        if let latitudeString = latitude,
           let longitudeString = longitude {
            
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
    
    func convertAddressToCoordinates(il: String, ilce: String, mahalle: String, sokak: String, completion: @escaping (Double?, Double?) -> Void) {
        let geocoder = CLGeocoder()
        let address = "\(il), \(ilce), \(mahalle), \(sokak)"
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                completion(nil, nil)
                return
            }
            
            if let placemark = placemarks?.first,
               let latitude = placemark.location?.coordinate.latitude,
               let longitude = placemark.location?.coordinate.longitude {
                completion(latitude, longitude)
            } else {
                completion(nil, nil)
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

extension CreateOrderViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == offerTF {
            if let offer = offerTF.text {
                finalOfferAmountLbl.text = "\(offer) TL"
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        // Sadece sayıları kontrol etmek için bir karakter kümesi oluşturun
        let characterSet = CharacterSet(charactersIn: "0123456789")
        
        // Girilen metni kontrol edin ve yalnızca sayıları kabul edin
        if text.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        
        // 999'dan büyük bir sayının girilmesini engelleyin
        if let number = Int(text), number > 999 {
            showErrorAlert()
            textField.text = ""
            return false
        }
        
        return true
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Hata", message: "Lütfen verebileceğiniz teklif limitini aşmayınız.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
