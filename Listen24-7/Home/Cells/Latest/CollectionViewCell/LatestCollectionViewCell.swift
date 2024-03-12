//
//  LatestCollectionViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class LatestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblMinutes: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    static let identifier = "LatestCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
