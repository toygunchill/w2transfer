//
//  RegisterViewController.swift
//  algel
//
//  Created by Toygun Çil on 7.04.2023.
//

import UIKit
import MaterialComponents
import DropDown

class RegisterViewController: UIViewController {
    
    let viewModel = RegisterViewModel()

    @IBOutlet weak var genderDropBtn: UIButton!
    @IBOutlet weak var surnameTf: MDCOutlinedTextField!
    @IBOutlet weak var nameTF: MDCOutlinedTextField!
    @IBOutlet weak var registerBtn: MDCButton!
    @IBOutlet weak var spassTf: MDCOutlinedTextField!
    @IBOutlet weak var fpassTf: MDCOutlinedTextField!
    @IBOutlet weak var emailTf: MDCOutlinedTextField!
    @IBOutlet weak var phoneTf: MDCOutlinedTextField!
    
    let gender = ["Erkek", "Kadın"]
    let genderDropDown = DropDown()
    var selectedGender: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        navigationController?.title = "Register"
        configureBackgroundColor()
        surnameTf.delegate = self
        nameTF.delegate = self
        spassTf.delegate = self
        fpassTf.delegate = self
        emailTf.delegate = self
        phoneTf.delegate = self
        
        configureBTN(btn: registerBtn,
                     title: "Register",
                     cornerRadius: 12,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        
        configureOTF(tf: phoneTf,
                    text: "Phone Number",
                    placeholder: "05*********",
                    normalColor: UIColor.black,
                    editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        configureOTF(tf: emailTf,
                    text: "E-mail",
                    placeholder: "info@algel.com",
                    normalColor: UIColor.black,
                    editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        configureOTF(tf: fpassTf,
                    text: "Password",
                    placeholder: "*******",
                    normalColor: UIColor.black,
                    editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        configureOTF(tf: spassTf,
                    text: "Password",
                    placeholder: "*******",
                    normalColor: UIColor.black,
                    editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        configureOTF(tf: nameTF,
                     text: "Name",
                     placeholder: "",
                     normalColor: UIColor.black,
                     editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        configureOTF(tf: surnameTf,
                     text: "Surname",
                     placeholder: "",
                     normalColor: UIColor.black,
                     editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        registerBtn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        setDropDown()
    }
    
    func setDropDown() {
        genderDropDown.anchorView = genderDropBtn
        genderDropDown.dataSource = gender
        
        genderDropBtn.tintColor = .black
        genderDropBtn.setTitle("Cinsiyetinizi Seçiniz", for: .normal)
        genderDropBtn.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
        genderDropBtn.layer.cornerRadius = 12
        
        genderDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            genderDropBtn.setTitle(item, for: .normal)
            selectedGender = item
            // İlçe Dropdown listesini güncelle
            genderDropBtn.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
        }
    }
    
    func validateFields() -> Bool {
        guard let name = nameTF.text, !name.isEmpty else {
            showAlert(with: "Error", message: "Please enter your name.")
            return false
        }
        
        guard let surname = surnameTf.text, !surname.isEmpty else {
            showAlert(with: "Error", message: "Please enter your surname.")
            return false
        }
        
        guard let email = emailTf.text, !email.isEmpty else {
            showAlert(with: "Error", message: "Please enter your email.")
            return false
        }
        
        if !isValidEmail(email) {
            showAlert(with: "Error", message: "Please enter a valid email address.")
            return false
        }
        
        guard let password = fpassTf.text, !password.isEmpty else {
            showAlert(with: "Error", message: "Please enter a password.")
            return false
        }
        
        guard let confirmPassword = spassTf.text, !confirmPassword.isEmpty else {
            showAlert(with: "Error", message: "Please confirm your password.")
            return false
        }
        
        if password != confirmPassword {
            showAlert(with: "Error", message: "Passwords do not match.")
            return false
        }
        
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
    
    @objc func registerBtnTapped() {
        if validateFields()  {
            viewModel.postSignUp(password: fpassTf.text,
                                 phone: phoneTf.text,
                                 email: emailTf.text,
                                 name: nameTF.text,
                                 surname: surnameTf.text,
                                 gender: selectedGender) { result in
                if result == "true"{
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func genderDropBtnTapped(_ sender: Any) {
        genderDropDown.show()
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Sonraki textfield'a geçmek için Return tuşunu kullan
        if textField == phoneTf {
            emailTf.becomeFirstResponder()
        } else if textField == emailTf {
            fpassTf.becomeFirstResponder()
        } else if textField == fpassTf {
            spassTf.becomeFirstResponder()
        } else if textField == spassTf {
            nameTF.becomeFirstResponder()
        } else if textField == nameTF {
            surnameTf.becomeFirstResponder()
        } else if textField == surnameTf {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
