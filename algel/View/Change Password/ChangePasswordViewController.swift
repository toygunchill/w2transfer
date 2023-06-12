//
//  ChangePasswordViewController.swift
//  algel
//
//  Created by Toygun Çil on 7.04.2023.
//

import UIKit
import MaterialComponents

class ChangePasswordViewController: UIViewController {
    
    let viewModel = ChangePasswordViewModel()

    @IBOutlet weak var confirmBtn: MDCButton!
    @IBOutlet weak var spassTF: MDCOutlinedTextField!
    @IBOutlet weak var fpassTF: MDCOutlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        fpassTF.delegate = self
        spassTF.delegate = self
        
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
        if validateFields() {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func validateFields() -> Bool {
        guard let fpass = fpassTF.text,
              !fpass.isEmpty,
              let spass = spassTF.text,
              !spass.isEmpty else {
            showAlert(with: "Error", message: "Please enter password.")
            return false
        }
        if fpass != spass {
            showAlert(with: "Error", message: "Passwords do not match.")
            return false
        }
        return true
    }
}

extension ChangePasswordViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let characterSet = CharacterSet(charactersIn: "0123456789")
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        if text.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        let maxLength: Int
        if textField == fpassTF {
            maxLength = 6
        } else if textField == spassTF {
            maxLength = 6
        } else {
            maxLength = 0
        }
        let currentLength = textField.text?.count ?? 0
        let newLength = currentLength + string.count - range.length
        return newLength <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Sonraki textfield'a geçmek için Return tuşunu kullan
        if textField == fpassTF {
            spassTF.becomeFirstResponder()
        } else if textField == spassTF {
            textField.resignFirstResponder()
        }
        return true
    }
}
