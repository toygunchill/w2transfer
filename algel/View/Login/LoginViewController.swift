//
//  ViewController.swift
//  algel
//
//  Created by Toygun Çil on 7.04.2023.
//

import UIKit
import Alamofire
import MaterialComponents

class LoginViewController: UIViewController {
    
    var timer: Timer?
    let viewModel = LoginViewModel()

    @IBOutlet weak var registerBtn: MDCButton!
    @IBOutlet weak var forgotLbl: UILabel!
    @IBOutlet weak var passwordTF: MDCOutlinedTextField!
    @IBOutlet weak var phoneTF: MDCOutlinedTextField!
    @IBOutlet weak var loginBtn: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        configureBackgroundColor()
        passwordTF.delegate = self
        phoneTF.delegate = self
        passwordTF.keyboardType = .numberPad
        phoneTF.keyboardType = .numberPad
        
        configureOTF(tf: phoneTF,
                    text: "Phone Number",
                    placeholder: "05*********",
                    normalColor: UIColor.black,
                     editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        configureOTF(tf: passwordTF,
                    text: "Password",
                    placeholder: "*******",
                    normalColor: UIColor.black,
                    editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        configureBTN(btn: loginBtn,
                     title: "LOGIN",
                     cornerRadius: 12,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        
        configureBTN(btn: registerBtn,
                     title: "REGISTER",
                     cornerRadius: 12,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        
        loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        registerBtn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        
        let tapForgotGesture = UITapGestureRecognizer(target: self, action: #selector(forgotLblTapped))
        
        configureTouchableLBL(lbl: forgotLbl,
                              text: "Forgot Password?",
                              txtColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                              alignment: .right,
                              gesture: tapForgotGesture)
    }

    @objc func forgotLblTapped() {
        self.forgotLbl.textColor = UIColor.orange
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
            self.forgotLbl.textColor = UIColor.systemOrange
        }
        if let forgotVC = storyboard?.instantiateViewController(withIdentifier: "ForgotViewController") as? ForgotViewController {
            self.navigationController?.pushViewController(forgotVC, animated: true)
            self.navigationController?.isNavigationBarHidden = false
        }
    }
    
    @objc func loginBtnTapped() {
        
        guard let phoneNumber = phoneTF.text, !phoneNumber.isEmpty else {
            showAlert(with: "Hata", message: "Telefon numarası boş olamaz")
            return
        }
        
        guard isValidPhoneNumber(phoneNumber) else {
            showAlert(with: "Hata", message: "Geçersiz telefon numarası")
            return
        }
        
        guard let password = passwordTF.text, !password.isEmpty else {
            showAlert(with: "Hata", message: "Şifre boş olamaz")
            return
        }
        
        
        if let password = passwordTF.text, password != "",
           let phone = phoneTF.text, phone != "" {
            viewModel.postSignIn(password: password, phone: phone) {
                if let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                    self.navigationController?.pushViewController(tabVC, animated: true)
                    self.navigationController?.isNavigationBarHidden = true
                }
            }
        }
    }
    
    @objc func registerBtnTapped() {
        if let registerVC = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            self.navigationController?.pushViewController(registerVC, animated: true)
            self.navigationController?.isNavigationBarHidden = false
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let characterSet = CharacterSet(charactersIn: "0123456789")
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        if text.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        let maxLength: Int
        if textField == phoneTF {
            maxLength = 10
        } else if textField == passwordTF {
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
        if textField == phoneTF {
            passwordTF.becomeFirstResponder()
        } else if textField == passwordTF {
            textField.resignFirstResponder()
        }
        return true
    }
}


