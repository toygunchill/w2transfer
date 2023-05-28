//
//  ForgotViewController.swift
//  algel
//
//  Created by Toygun Çil on 7.04.2023.
//

import UIKit
import MaterialComponents

class ForgotViewController: UIViewController {

    @IBOutlet weak var sendCodeBtn: MDCButton!
    @IBOutlet weak var phoneTf: MDCOutlinedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationController?.title = "Forgot Password"
        configureBackgroundColor()
        
        configureOTF(tf: phoneTf,
                     text: "Phone Number",
                     placeholder: "05*********",
                     normalColor: UIColor.black,
                     editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        configureBTN(btn: sendCodeBtn,
                     title: "SEND CODE",
                     cornerRadius: 12,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        
        sendCodeBtn.addTarget(self, action: #selector(sendCodeBtnTapped), for: .touchUpInside)
    }
    
    @objc func sendCodeBtnTapped() {
        if let registerVC = storyboard?.instantiateViewController(withIdentifier: "CodeViewController") as? CodeViewController {
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
}
