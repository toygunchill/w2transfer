//
//  Extension+UIViewController.swift
//  algel
//
//  Created by Toygun Çil on 27.05.2023.
//

import UIKit
import MaterialComponents

extension UIViewController {
    func configureOTF(tf: MDCOutlinedTextField?,
                      text: String?,
                      placeholder: String?,
                      normalColor: UIColor?,
                      editColor: UIColor?) {
        if let nclr = normalColor, let eclr = editColor, let ph = placeholder, let txt = text {
            tf?.label.text = txt
            tf?.placeholder = ph
            tf?.setOutlineColor(nclr,
                                for: .normal)
            tf?.setOutlineColor(eclr,
                                for: .editing)
        }
        tf?.sizeToFit()
    }
    
    func configureBTN(btn: MDCButton?,
                      title: String?,
                      cornerRadius: Int?,
                      bgColor: UIColor?,
                      inkColor: UIColor?) {
        btn?.accessibilityLabel = "Create"
        if let cr = cornerRadius, let iclr = inkColor, let bclr = bgColor, let ttl = title {
            btn?.inkColor = iclr
            btn?.backgroundColor = bclr
            btn?.setTitle(ttl, for: .normal)
            btn?.layer.cornerRadius = CGFloat(cr)
            btn?.tintColor = UIColor.white
        }
        btn?.sizeToFit()
    }
    
    func configureTouchableLBL(lbl: UILabel?,
                               text: String?,
                               txtColor: UIColor?,
                               alignment: NSTextAlignment?,
                               gesture: UITapGestureRecognizer?){
        lbl?.text = text
        lbl?.textColor = txtColor
        if let align = alignment, let ges = gesture, let txt = text, let txtclr = txtColor {
            lbl?.text = txt
            lbl?.textColor = txtclr
            lbl?.textAlignment = align
            lbl?.addGestureRecognizer(ges)
        }
        lbl?.isUserInteractionEnabled = true
        lbl?.sizeToFit()
    }
    
    func configureTouchableIV(iv: UIImageView?,
                              gestrue: UITapGestureRecognizer?) {
        if let checkedIV = iv {
            if let checkedGesture = gestrue {
                checkedIV.addGestureRecognizer(checkedGesture)
            }
            checkedIV.isUserInteractionEnabled = true
            checkedIV.sizeToFit()
        }
    }
    
    func configureFTF(tf: MDCFilledTextField?,
                      text: String?,
                      placeholder: String?) {
        if let ph = placeholder {
            tf?.placeholder = ph
        }
        if let txt = text {
            tf?.label.text = txt
        }
        tf?.sizeToFit()
    }
    
    func configureBackgroundColor() {
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
    }
    
    //MARK: - Textfield controll
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneNumberRegex = "^\\d{10}$"
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phoneNumberPredicate.evaluate(with: phoneNumber)
    }
    
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
