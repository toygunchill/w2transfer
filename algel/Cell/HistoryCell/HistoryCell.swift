//
//  HistoryCell.swift
//  algel
//
//  Created by Toygun Çil on 4.05.2023.
//

import UIKit

class HistoryCell: UICollectionViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var takenRoadLabel: UILabel!
    @IBOutlet weak var takenRoadHeaderLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountHeaderLabel: UILabel!
    @IBOutlet weak var productTypeHeaderLabel: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        cellBackgroundView.layer.cornerRadius = 12
        cellBackgroundView.backgroundColor = UIColor.white
        
    }
}
