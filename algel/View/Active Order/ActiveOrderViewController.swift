//
//  ActiveOrderViewController.swift
//  algel
//
//  Created by Toygun Çil on 19.05.2023.
//

import UIKit
import MaterialComponents
import Lottie

class ActiveOrderViewController: UIViewController {
    
    let viewModel = ActiveOrderViewModel()

    @IBOutlet weak var offerLbl: UILabel!
    @IBOutlet weak var productTypeLbl: UILabel!
    @IBOutlet weak var locationLeftLbl: UILabel!
    @IBOutlet weak var locationGiveLbl: UILabel!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var acceptBtn: MDCButton!
    @IBOutlet weak var infoIV: UIImageView!
    
    private var animationView: LottieAnimationView?
    var timer: Timer?
    var activeOrder: OrderListResponseElement? = GlobalService.sharedGlobal.activeOrder
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        configureBTN(btn: acceptBtn,
                     title: "CONFIRM",
                     cornerRadius: 12,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        activeOrder = GlobalService.sharedGlobal.activeOrder
        if let type = activeOrder?.type {
            productTypeLbl.text = "Weight = \(String(describing: type))"
        }
        if let pickupAdress = activeOrder?.pickupAdress {
            locationGiveLbl.text = "Pickup = \(String(describing: pickupAdress))"
        }
        if let dropAdress = activeOrder?.dropAdress {
            locationLeftLbl.text = "Drop = \(String(describing: dropAdress))"
        }
        if let note = activeOrder?.note {
            noteLbl.text = "Note = \(String(describing: note))"
        }
        if let price = activeOrder?.price{
            offerLbl.text = "Price = \(String(describing: price))"
        }
    }
    
    @IBAction func tapAcceptButton(_ sender: Any) {
        let view = UIView()
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        view.backgroundColor = UIColor.white
        
        setupSplashLabel(view: view)
        
//        viewModel.postDropCheck(orderID: <#T##String?#>,
//                                transporterID: <#T##String?#>,
//                                userID: <#T##String?#>) {
//            <#code#>
//        }
    }
    
    private func setupSplashLabel(view: UIView!) {
        animationView = .init(name: "accept.json")
        setupSplashAnimation(view: view)
    }
    
    func setupSplashAnimation(view: UIView!) {
        animationView!.frame = self.view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        animationView!.loopMode = .playOnce
        view.addSubview(animationView!)
        animationView!.play()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false) { timer in
            if let activeVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCommentViewController") as? AddCommentViewController {
                self.navigationController?.pushViewController(activeVC, animated: true)
            }
        }
    }
}
