//
//  SendCodeViewController.swift
//  algel
//
//  Created by Toygun Çil on 7.04.2023.
//

import UIKit
import MaterialComponents

class CodeViewController: UIViewController {
    
    let viewModel = CodeViewModel()
    
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
        configureBackgroundColor()
        
        fcodeTf.delegate = self
        scodeTf.delegate = self
        tcodeTf.delegate = self
        lastcodeTf.delegate = self
        
        fcodeTf.keyboardType = .numberPad
        scodeTf.keyboardType = .numberPad
        tcodeTf.keyboardType = .numberPad
        lastcodeTf.keyboardType = .numberPad
        
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
        if validateFields() {
            if fcodeTf.text == "1",
               scodeTf.text == "1",
               tcodeTf.text == "1",
               lastcodeTf.text == "1" {
                if let changeVC = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as? ChangePasswordViewController {
                    self.navigationController?.pushViewController(changeVC, animated: true)
                }
            }
        }
    }
    
    func validateFields() -> Bool {
        guard let fText = fcodeTf.text,
              !fText.isEmpty,
              let sText = scodeTf.text,
              !sText.isEmpty,
              let tText = tcodeTf.text,
              !tText.isEmpty,
              let lText = lastcodeTf.text,
              !lText.isEmpty else {
            showAlert(with: "Error", message: "Please enter your confirm code.")
            return false
        }
        
        return true
    }
}

extension CodeViewController: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let characterSet = CharacterSet(charactersIn: "0123456789")
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        if text.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        let maxLength: Int
        if textField == fcodeTf {
            maxLength = 1
        } else if textField == scodeTf {
            maxLength = 1
        } else if textField == tcodeTf {
            maxLength = 1
        } else if textField == lastcodeTf {
            maxLength = 1
        } else {
            maxLength = 0
        }
        let currentLength = textField.text?.count ?? 0
        let newLength = currentLength + string.count - range.length
        return newLength <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Sonraki textfield'a geçmek için Return tuşunu kullan
        if textField == fcodeTf {
            scodeTf.becomeFirstResponder()
        } else if textField == scodeTf {
            tcodeTf.becomeFirstResponder()
        } else if textField == tcodeTf {
            lastcodeTf.becomeFirstResponder()
        } else if textField == lastcodeTf {
            textField.resignFirstResponder()
        }
        return true
    }
}
