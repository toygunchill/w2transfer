//
//  CommentsCell.swift
//  algel
//
//  Created by Toygun Çil on 7.05.2023.
//

import UIKit

class CommentsCell: UICollectionViewCell {

    @IBOutlet weak var commentBackgroundView: UIView!
    @IBOutlet weak var commentAmountLbl: UILabel!
    @IBOutlet weak var commentNameLbl: UILabel!
    @IBOutlet weak var commentLocationLbl: UILabel!
    @IBOutlet weak var commentLocationIV: UIImageView!
    @IBOutlet weak var commentInfoLbl: UILabel!
    @IBOutlet weak var commentScoreLbl: UILabel!
    @IBOutlet weak var commentScoreIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        commentBackgroundView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        commentBackgroundView.layer.cornerRadius = 12
        
    }

}
