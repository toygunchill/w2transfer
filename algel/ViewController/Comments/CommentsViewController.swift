//
//  CommentsViewController.swift
//  algel
//
//  Created by Toygun Çil on 7.05.2023.
//

import UIKit

class CommentsViewController: UIViewController {
    
    let viewModel = CommentsViewModel()
    var commentList: CommentListResponse? {
        didSet {
            commentCV.reloadData()
        }
    }
    var commentOtherDataList: OrderListHistoryResponse? {
        didSet {
            commentCV.reloadData()
        }
    }

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        commentCV.delegate = self
        commentCV.dataSource = self
        commentCV.register(UINib(nibName: String(describing: CommentsCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CommentsCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getCommentList(userID: GlobalService.sharedGlobal.userID) { result in
            self.commentList = result
            self.commentOtherDataList = []
            GlobalService.sharedGlobal.orderListHistory?.forEach({ orderHist in
                self.commentList?.forEach { comment in
                    if orderHist.id == comment.orderID, orderHist.active == "0"{
                        self.commentOtherDataList?.append(orderHist)
                    }
                }
            })
        }
    }
    
    func setupUI() {
        configureBackgroundColor()
        commentCV.backgroundColor = .clear
    }

}

extension CommentsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //MARK: - otherdatalist'e geçtim çünkü api'den önce commentlist'i çekip ona göre commentotherdata'yı oluşturuyorduk. Bu oluşturma esnasında collectionView oluşturulduğu için crash veriyorudu.
        return commentOtherDataList?.count ?? 0
        //return commentList?.count ?? 0
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
        
        var comment = commentList?[indexPath.item].comment
        let components = comment?.components(separatedBy: " ")
        
        if let components = components {
            if components.count >= 2 {
                let firstTwoWords = components[0...1].joined(separator: " ")
                comment = firstTwoWords
            }
        }
        
        commentCell.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 2, y: 2, blur: 10, spread: 0)
        commentCell.commentScoreLbl.text = commentList?[indexPath.item].rating
        commentCell.commentInfoLbl.text = commentList?[indexPath.item].comment
        commentCell.commentAmountLbl.text = commentOtherDataList?[indexPath.item].price
        commentCell.commentNameLbl.text = comment
        commentCell.commentLocationLbl.text = addressString
        return commentCell
    }
    
    
}
