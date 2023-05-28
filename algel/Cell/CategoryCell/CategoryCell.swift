//
//  CategoryCell.swift
//  algel
//
//  Created by Toygun Çil on 4.05.2023.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        categoryView.layer.cornerRadius = 12
    }

}
