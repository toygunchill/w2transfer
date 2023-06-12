//
//  ProfileViewController.swift
//  algel
//
//  Created by Toygun Çil on 7.05.2023.
//

import UIKit
import MaterialComponents

class ProfileViewController: UIViewController {
    
    let viewModel = ProfileViewModel()
    var fiveComments: CommentListResponse? {
        didSet {
            commentCV.reloadData()
        }
    }
    var commentOtherDataList: OrderListHistoryResponse? {
        didSet {
            commentCV.reloadData()
        }
    }
    
    var commentList: CommentListResponse?
    
    var rating: Int = 0
    var averageRating: Double = 0.00 {
        didSet {
            if averageRating > 0.00 && averageRating < 2.00 {
                fScoreIV.image = UIImage(systemName: "star.fill")
                sScoreIV.image = UIImage(systemName: "star")
                tScoreIV.image = UIImage(systemName: "star")
                fouthScoreIV.image = UIImage(systemName: "star")
                lastScoreIV.image = UIImage(systemName: "star")
            } else if averageRating >= 2.00 && averageRating < 3.00 {
                fScoreIV.image = UIImage(systemName: "star.fill")
                sScoreIV.image = UIImage(systemName: "star.fill")
                tScoreIV.image = UIImage(systemName: "star")
                fouthScoreIV.image = UIImage(systemName: "star")
                lastScoreIV.image = UIImage(systemName: "star")
            } else if averageRating >= 3.00 && averageRating < 4.00 {
                fScoreIV.image = UIImage(systemName: "star.fill")
                sScoreIV.image = UIImage(systemName: "star.fill")
                tScoreIV.image = UIImage(systemName: "star.fill")
                fouthScoreIV.image = UIImage(systemName: "star")
                lastScoreIV.image = UIImage(systemName: "star")
            } else if averageRating >= 4.00 && averageRating < 5.00 {
                fScoreIV.image = UIImage(systemName: "star.fill")
                sScoreIV.image = UIImage(systemName: "star.fill")
                tScoreIV.image = UIImage(systemName: "star.fill")
                fouthScoreIV.image = UIImage(systemName: "star.fill")
                lastScoreIV.image = UIImage(systemName: "star")
            } else if averageRating == 5.00 {
                fScoreIV.image = UIImage(systemName: "star.fill")
                sScoreIV.image = UIImage(systemName: "star.fill")
                tScoreIV.image = UIImage(systemName: "star.fill")
                fouthScoreIV.image = UIImage(systemName: "star.fill")
                lastScoreIV.image = UIImage(systemName: "star.fill")
            }
        }
    }
    var isFirst: Bool = true

    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var lastScoreIV: UIImageView!
    @IBOutlet weak var fouthScoreIV: UIImageView!
    @IBOutlet weak var tScoreIV: UIImageView!
    @IBOutlet weak var sScoreIV: UIImageView!
    @IBOutlet weak var fScoreIV: UIImageView!
    @IBOutlet weak var stackSV: UIStackView!
    @IBOutlet weak var exitLbl: UILabel!
    @IBOutlet weak var userAddressLbl: UILabel!
    @IBOutlet weak var userAddressIconIV: UIImageView!
    @IBOutlet weak var userAddressSV: UIStackView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userCardBaclgroundView: UIView!
    @IBOutlet weak var userProfileIV: UIImageView!
    @IBOutlet weak var commentCV: UICollectionView!
    @IBOutlet weak var userSeperatorView: UIView!
    @IBOutlet weak var commentAllBtn: MDCButton!
    @IBOutlet weak var commentLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentCV.delegate = self
        commentCV.dataSource = self
        commentCV.register(UINib(nibName: String(describing: CommentsCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CommentsCell.self))
        setData()
        setupUI()
        isFirst = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isFirst == false {
            setData()
            setupUI()
        }
    }
    
    func setData() {
        viewModel.getOrderListHistory(userID: GlobalService.sharedGlobal.userID) { value in
            GlobalService.sharedGlobal.orderListHistory = value
            self.viewModel.getCommentList(userID: GlobalService.sharedGlobal.userID) { result in
                self.commentList = result
                self.fiveComments = Array(result.prefix(5))
                self.commentOtherDataList = []
                GlobalService.sharedGlobal.orderListHistory?.forEach({ orderHist in
                    self.fiveComments?.forEach { comment in
                        if orderHist.id == comment.orderID, orderHist.active == "0"{
                            self.commentOtherDataList?.append(orderHist)
                        }
                    }
                })
                self.commentList?.forEach({ item in
                    if let stringRating = item.rating,
                       let itemRating = Int(stringRating) {
                        self.rating = itemRating + self.rating
                    }
                })
                if let count = self.commentList?.count ,
                   count > 0 {
                    self.averageRating = Double(self.rating) / Double(count)
                }
                let setRating = self.averageRating
                self.averageRating = setRating
                self.commentCV.reloadData()
            }
        }
    }
    
    func setupUI() {
        configureBackgroundColor()
        
        let starArr = [fScoreIV, sScoreIV, tScoreIV, fouthScoreIV, lastScoreIV]
        starArr.forEach { item in
            item?.tintColor = UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0)
        }
        
        userProfileIV.layer.cornerRadius = userProfileIV.layer.frame.width/2
        userProfileIV.layer.borderWidth = 0.5
        userProfileIV.layer.borderColor = UIColor.white.cgColor
        
        userCardBaclgroundView.layer.cornerRadius = 20
        userCardBaclgroundView.backgroundColor = UIColor(red: 238/255, green: 247/255, blue: 254/255, alpha: 1.0)
        userCardBaclgroundView.layer.applySketchShadow(color: UIColor.black, alpha: 0.05, x: 0, y: 4, blur: 10, spread: 0)
        
        commentCV.backgroundColor = UIColor.clear
        commentLbl.text = "Comments"
        
        configureBTN(btn: commentAllBtn,
                     title: "SEE ALL",
                     cornerRadius: 6,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        
        let tapExitGesture = UITapGestureRecognizer(target: self, action: #selector(exitBtnTapped))
        
        configureTouchableLBL(lbl: exitLbl,
                              text: "EXIT",
                              txtColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                              alignment: .right,
                              gesture: tapExitGesture)
        
        viewModel.getUserDetail(userID: GlobalService.sharedGlobal.userID) { value in
            //MARK: - GlobalService'de datayı setledim
            GlobalService.sharedGlobal.userPhone = value[0].phoneNumber
            GlobalService.sharedGlobal.userGender = value[0].gender
            GlobalService.sharedGlobal.userEmail = value[0].email
            GlobalService.sharedGlobal.userName = value[0].name
            GlobalService.sharedGlobal.userSurname = value[0].surname
            //MARK: - Gelen datayı ilgili yerlere setledim
            self.phoneNumberLbl.text = value[0].phoneNumber
            self.emailLbl.text = value[0].email
            self.userNameLbl.text = "\(String(describing: value[0].name)) \(String(describing: value[0].surname ))"
            if GlobalService.sharedGlobal.userGender == "0" {
                self.userProfileIV.image = UIImage(named: "Users")
            } else {
                self.userProfileIV.image = UIImage(named: "")
            }
        }
    }
    
    @objc func exitBtnTapped() {
        
    }
    
    @IBAction func commentAllBtnTapped(_ sender: Any) {
        if let commentsVC = storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as? CommentsViewController {
            self.navigationController?.pushViewController(commentsVC, animated: true)
        }
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commentOtherDataList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let commentCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CommentsCell.self), for: indexPath) as? CommentsCell else {
            return UICollectionViewCell()
        }
        
        var addressString: String = ""
        
        if let dropAddress = commentOtherDataList?[indexPath.item].dropAdress,
           let pickupAddress = commentOtherDataList?[indexPath.item].pickupAdress {
            let dropComponents = dropAddress.components(separatedBy: "-")
            let pickupComponents = pickupAddress.components(separatedBy: "-")
            
            if pickupComponents.count >= 2 {
                let pickupIlce = pickupComponents[1].trimmingCharacters(in: .whitespaces)
                addressString += pickupIlce
            }
            
            addressString += "-"
            
            if dropComponents.count >= 2 {
                let dropIlce = dropComponents[1].trimmingCharacters(in: .whitespaces)
                addressString += dropIlce
            }
        }
        
        var comment = fiveComments?[indexPath.item].comment
        let components = comment?.components(separatedBy: " ")
        
        if let components = components {
            if components.count >= 2 {
                let firstTwoWords = components[0...1].joined(separator: " ")
                comment = firstTwoWords
            }
        }
        
        commentCell.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 2, y: 2, blur: 10, spread: 0)
        commentCell.commentScoreLbl.text = fiveComments?[indexPath.item].rating
        commentCell.commentInfoLbl.text = fiveComments?[indexPath.item].comment
        commentCell.commentAmountLbl.text = "\(String(describing: commentOtherDataList?[indexPath.item].price)) TL"
        commentCell.commentNameLbl.text = comment
        commentCell.commentLocationLbl.text = addressString
        return commentCell
    }
    
    
}
