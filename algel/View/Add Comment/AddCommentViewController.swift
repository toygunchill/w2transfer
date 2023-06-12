//
//  AddCommentViewController.swift
//  algel
//
//  Created by Toygun Çil on 21.05.2023.
//

import UIKit
import MaterialComponents

class AddCommentViewController: UIViewController {
    
    let viewModel = AddCommentViewModel()
    
    @IBOutlet weak var addCommentBtn: MDCButton!
    @IBOutlet weak var addCommentTF: MDCOutlinedTextField!
    @IBOutlet weak var addCommentLbl: UILabel!
    @IBOutlet weak var starFive: UIImageView!
    @IBOutlet weak var starFour: UIImageView!
    @IBOutlet weak var starThree: UIImageView!
    @IBOutlet weak var starTwo: UIImageView!
    @IBOutlet weak var starOne: UIImageView!
    @IBOutlet weak var starSV: UIStackView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var userView: UIView!
    
    var starPoint: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let starArr = [starOne, starTwo, starThree, starFour, starFive]
        starArr.forEach { item in
            item?.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
        }
        
        let starOneGesture = UITapGestureRecognizer(target: self, action: #selector(starOneTapped))
        let starTwoGesture = UITapGestureRecognizer(target: self, action: #selector(starTwoTapped))
        let starThreeGesture = UITapGestureRecognizer(target: self, action: #selector(starThreeTapped))
        let starFourGesture = UITapGestureRecognizer(target: self, action: #selector(starFourTapped))
        let starFiveGesture = UITapGestureRecognizer(target: self, action: #selector(starFiveTapped))
        
        configureTouchableIV(iv: starOne, gestrue: starOneGesture)
        configureTouchableIV(iv: starTwo, gestrue: starTwoGesture)
        configureTouchableIV(iv: starThree, gestrue: starThreeGesture)
        configureTouchableIV(iv: starFour, gestrue: starFourGesture)
        configureTouchableIV(iv: starFive, gestrue: starFiveGesture)
        
        configureBTN(btn: addCommentBtn,
                     title: "ADD COMMENT",
                     cornerRadius: 12,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        
        configureOTF(tf: addCommentTF,
                     text: "Please Add Comment",
                     placeholder: "",
                     normalColor: UIColor.black,
                     editColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0))
        
        addCommentLbl.text = "Please Add Comment"
    }
    
    @objc func starOneTapped() {
        starOne.image = UIImage(systemName: "star.fill")
        starTwo.image = UIImage(systemName: "star")
        starThree.image = UIImage(systemName: "star")
        starFour.image = UIImage(systemName: "star")
        starFive.image = UIImage(systemName: "star")
        
        starPoint = 1
    }
    
    @objc func starTwoTapped() {
        starOne.image = UIImage(systemName: "star.fill")
        starTwo.image = UIImage(systemName: "star.fill")
        starThree.image = UIImage(systemName: "star")
        starFour.image = UIImage(systemName: "star")
        starFive.image = UIImage(systemName: "star")
        
        starPoint = 2
    }
    
    @objc func starThreeTapped() {
        starOne.image = UIImage(systemName: "star.fill")
        starTwo.image = UIImage(systemName: "star.fill")
        starThree.image = UIImage(systemName: "star.fill")
        starFour.image = UIImage(systemName: "star")
        starFive.image = UIImage(systemName: "star")
        
        starPoint = 3
    }
    
    @objc func starFourTapped() {
        starOne.image = UIImage(systemName: "star.fill")
        starTwo.image = UIImage(systemName: "star.fill")
        starThree.image = UIImage(systemName: "star.fill")
        starFour.image = UIImage(systemName: "star.fill")
        starFive.image = UIImage(systemName: "star")
        
        starPoint = 4
    }
    
    @objc func starFiveTapped() {
        starOne.image = UIImage(systemName: "star.fill")
        starTwo.image = UIImage(systemName: "star.fill")
        starThree.image = UIImage(systemName: "star.fill")
        starFour.image = UIImage(systemName: "star.fill")
        starFive.image = UIImage(systemName: "star.fill")
        
        starPoint = 5
    }
    
    @IBAction func addCommentBtnTapped(_ sender: Any) {
        if let comment = addCommentTF.text,
           let starPoint = starPoint {
            if comment.isEmpty {
                showAlert(with: "Hata", message: "Yorum alanı boş bırakılamaz.")
            } else if starPoint == 0 {
                showAlert(with: "Hata", message: "Yorum puanı boş bırakılamaz.")
            } else if !String(starPoint).isEmpty, !comment.isEmpty {
                viewModel.postComment(commentString: comment,
                                      ratingString: String(starPoint)) { result in
                    if result == "true" {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
        }
    }
}
