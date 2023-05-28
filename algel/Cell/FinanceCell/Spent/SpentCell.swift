//
//  SpentCell.swift
//  algel
//
//  Created by Toygun Çil on 6.05.2023.
//

import UIKit

class SpentCell: UICollectionViewCell {

    @IBOutlet weak var spentBackgroundView: UIView!
    @IBOutlet weak var downIconImageView: UIImageView!
    @IBOutlet weak var progresView: UIProgressView!
    @IBOutlet weak var payBackgroundView: UIView!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
