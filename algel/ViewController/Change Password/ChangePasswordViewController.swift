//
//  ChangePasswordViewController.swift
//  algel
//
//  Created by Toygun Çil on 7.04.2023.
//

import UIKit
import MaterialComponents

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var confirmBtn: MDCButton!
    @IBOutlet weak var spassTF: MDCOutlinedTextField!
    @IBOutlet weak var fpassTF: MDCOutlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationController?.title = "Change Password"
        configureBackgroundColor()
        
        configureOTF(tf: fpassTF,
                    text: "Password",
                    placeholder: "*******",
                    normalColor: UIColor.black,
                    editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        configureOTF(tf: spassTF,
                    text: "Password",
                    placeholder: "*******",
                    normalColor: UIColor.black,
                    editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        configureBTN(btn: confirmBtn,
                     title: "CONFIRM",
                     cornerRadius: 12,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        
        confirmBtn.addTarget(self, action: #selector(confirmBtnTapped), for: .touchUpInside)
    }
    
    @objc func confirmBtnTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
