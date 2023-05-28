//
//  SendCodeViewController.swift
//  algel
//
//  Created by Toygun Çil on 7.04.2023.
//

import UIKit
import MaterialComponents

class CodeViewController: UIViewController {
    @IBOutlet weak var codeTfSV: UIStackView!
    
    @IBOutlet weak var lastcodeTf: MDCFilledTextField!
    @IBOutlet weak var tcodeTf: MDCFilledTextField!
    @IBOutlet weak var scodeTf: MDCFilledTextField!
    @IBOutlet weak var fcodeTf: MDCFilledTextField!
    @IBOutlet weak var confirmBtn: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationController?.title = "Enter Code"
        configureBackgroundColor()
        
        configureFTF(tf: fcodeTf, text: "", placeholder: "")
        configureFTF(tf: scodeTf, text: "", placeholder: "")
        configureFTF(tf: tcodeTf, text: "", placeholder: "")
        configureFTF(tf: lastcodeTf, text: "", placeholder: "")
        
        fcodeTf.minimumFontSize = 70.0
        scodeTf.minimumFontSize = 70.0
        tcodeTf.minimumFontSize = 70.0
        lastcodeTf.minimumFontSize = 70.0
        
        configureBTN(btn: confirmBtn,
                     title: "CONFIRM",
                     cornerRadius: 12,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        
        confirmBtn.addTarget(self, action: #selector(confirmBtnTapped), for: .touchUpInside)
    }
    
    @objc func confirmBtnTapped() {
        if let changeVC = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as? ChangePasswordViewController {
            self.navigationController?.pushViewController(changeVC, animated: true)
        }
    }
}
