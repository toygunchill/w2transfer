//
//  ForgotViewController.swift
//  algel
//
//  Created by Toygun Çil on 7.04.2023.
//

import UIKit
import MaterialComponents

class ForgotViewController: UIViewController {
    
    let viewModel = ForgotViewModel()

    @IBOutlet weak var sendCodeBtn: MDCButton!
    @IBOutlet weak var phoneTf: MDCOutlinedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        configureBackgroundColor()
        
        phoneTf.delegate = self
        phoneTf.keyboardType = .numberPad
        
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
    
    func validateFields() -> Bool {
        guard let phoneNumber = phoneTf.text, !phoneNumber.isEmpty else {
            showAlert(with: "Error", message: "Please enter your phone number.")
            return false
        }
        
        if !isValidPhoneNumber(phoneNumber) {
            showAlert(with: "Error", message: "Please enter a valid phone number.")
            return false
        }
        
        return true
    }
    
    @objc func sendCodeBtnTapped() {
        if validateFields() {
            if let registerVC = storyboard?.instantiateViewController(withIdentifier: "CodeViewController") as? CodeViewController {
                self.navigationController?.pushViewController(registerVC, animated: true)
            }
        }
    }
}

extension ForgotViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let characterSet = CharacterSet(charactersIn: "0123456789")
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        if text.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        let maxLength: Int
        if textField == phoneTf {
            maxLength = 10
        } else {
            maxLength = 0
        }
        let currentLength = textField.text?.count ?? 0
        let newLength = currentLength + string.count - range.length
        return newLength <= maxLength
    }
}
