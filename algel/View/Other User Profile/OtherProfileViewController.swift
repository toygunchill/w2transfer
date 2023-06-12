//
//  OtherProfileViewController.swift
//  algel
//
//  Created by Toygun Çil on 23.05.2023.
//


import UIKit
import MaterialComponents

class OtherProfileViewController: UIViewController {
    
    let viewModel = OtherProfileViewModel()
    var fiveComments: CommentListResponse? {
        didSet {
            otherCommentCV.reloadData()
        }
    }
    
    @IBOutlet weak var emailHeaderLbl: UILabel!
    @IBOutlet weak var phoneHeaderLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var lastStarIV: UIImageView!
    @IBOutlet weak var foStarIV: UIImageView!
    @IBOutlet weak var tStarIV: UIImageView!
    @IBOutlet weak var sStarIV: UIImageView!
    @IBOutlet weak var fStarIV: UIImageView!
    @IBOutlet weak var starSV: UIStackView!
    @IBOutlet weak var otherCardBackgroundView: UIView!
    @IBOutlet weak var otherProfileIV: UIImageView!
    @IBOutlet weak var otherNameLbl: UILabel!
    @IBOutlet weak var otherAddressIconIV: UIImageView!
    @IBOutlet weak var otherAddressLbl: UILabel!
    @IBOutlet weak var otherAddressSV: UIStackView!
    @IBOutlet weak var otherSepView: UIView!
    @IBOutlet weak var otherCommentLbl: UILabel!
    @IBOutlet weak var otherCommentAllBtn: MDCButton!
    @IBOutlet weak var otherCommentCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otherCommentCV.delegate = self
        otherCommentCV.dataSource = self
        otherCommentCV.register(UINib(nibName: String(describing: CommentsCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CommentsCell.self))
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setupUI() {
        configureBackgroundColor()
        
        otherProfileIV.layer.cornerRadius = otherProfileIV.layer.frame.width/2
        otherProfileIV.layer.borderWidth = 0.5
        otherProfileIV.layer.borderColor = UIColor.white.cgColor
        
        otherCardBackgroundView.layer.cornerRadius = 20
        otherCardBackgroundView.backgroundColor = UIColor(red: 238/255, green: 247/255, blue: 254/255, alpha: 1.0)
        otherCardBackgroundView.layer.applySketchShadow(color: UIColor.black, alpha: 0.05, x: 0, y: 4, blur: 10, spread: 0)
        
        otherCommentCV.backgroundColor = UIColor.clear
        otherCommentLbl.text = "Comments"
        emailHeaderLbl.text = "Email :"
        phoneHeaderLbl.text = "Phone :"
        
        configureBTN(btn: otherCommentAllBtn,
                     title: "SEE ALL",
                     cornerRadius: 6,
                     bgColor: UIColor(red: 245/255, green: 89/255, blue: 84/255, alpha: 1.0),
                     inkColor: UIColor.white.withAlphaComponent(0.2))
        viewModel.getUserDetail(userID: GlobalService.sharedGlobal.otherUserID) { value in
            //MARK: - Gelen datayı ilgili yerlere setledim
            self.phoneNumberLbl.text = value[0].phoneNumber
            self.emailLbl.text = value[0].email
            self.otherNameLbl.text = "\(String(describing: value[0].name)) \(String(describing: value[0].surname ))"
            if value[0].gender == "0" {
                self.otherProfileIV.image = UIImage(named: "Users")
            } else {
                self.otherProfileIV.image = UIImage(named: "")
            }
        }
    }

    @IBAction func otherCommentAllBtnTapped(_ sender: Any) {
        if let commentsVC = storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as? CommentsViewController {
            self.navigationController?.pushViewController(commentsVC, animated: true)
        }
    }
}

extension OtherProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fiveComments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let commentCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CommentsCell.self), for: indexPath) as? CommentsCell else {
            return UICollectionViewCell()
        }
        commentCell.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 2, y: 2, blur: 10, spread: 0)
        commentCell.commentScoreLbl.text = fiveComments?[indexPath.item].rating
        commentCell.commentInfoLbl.text = fiveComments?[indexPath.item].comment
        return commentCell
    }
    
    
}

