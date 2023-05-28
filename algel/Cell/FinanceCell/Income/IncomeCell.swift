//
//  IncomeCell.swift
//  algel
//
//  Created by Toygun Çil on 6.05.2023.
//

import UIKit

class IncomeCell: UICollectionViewCell {

    @IBOutlet weak var incomeBackgroundView: UIView!
    @IBOutlet weak var upIconImageView: UIImageView!
    @IBOutlet weak var progresView: UIProgressView!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var payBackgroundView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
