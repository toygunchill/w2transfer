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

    @IBOutlet weak var exitLbl: UILabel!
    @IBOutlet weak var userInfoLbl: UILabel!
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
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getCommentList(userID: GlobalService.sharedGlobal.userID) { result in
            self.fiveComments = Array(result.prefix(5))
        }
    }
    
    func setupUI() {
        configureBackgroundColor()
        
        userProfileIV.layer.cornerRadius = userProfileIV.layer.frame.width/2
        userProfileIV.layer.borderWidth = 0.5
        userProfileIV.layer.borderColor = UIColor.white.cgColor
        
        userNameLbl.text = "Virginia Robinson"

        userInfoLbl.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare pretium placerat ut."
        
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
